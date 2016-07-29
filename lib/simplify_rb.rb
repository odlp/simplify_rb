require 'simplify_rb/version'
require 'simplify_rb/point'

module SimplifyRb
  class Simplifier
    def process(raw_points, tolerance = 1, highest_quality = false)
      raise ArgumentError.new('Points must be an array') unless raw_points.is_a? Array

      return raw_points if raw_points.length <= 1

      sq_tolerance = tolerance * tolerance

      points = raw_points.map { |p| Point.new(p) }
      points = simplify_radial_dist(points, sq_tolerance) unless highest_quality

      simplify_douglas_peucker(points, sq_tolerance)
        .map(&:to_h)
    end

    private

    class MaxSqDist < Struct.new(:max_sq_dist, :index)
    end

    # Basic distance-based simplification
    def simplify_radial_dist(points, sq_tolerance)
      new_points = [points.first]

      points.each do |point|
        sq_dist = point.get_sq_dist_to(new_points.last)
        new_points << point if sq_dist > sq_tolerance
      end

      new_points << points.last unless new_points.last == points.last

      new_points
    end

    # Optimized Douglas-Peucker algorithm
    def simplify_douglas_peucker(points, sq_tolerance)
      points.first.keep = true
      points.last.keep  = true

      perform_simplify_douglas_peucker(points, sq_tolerance)
        .select { |p| p.keep }
    end

    def perform_simplify_douglas_peucker(points, sq_tolerance)
      first_i = 0
      last_i  = points.length - 1
      index = nil
      stack = []

      while last_i
        result = calc_max_sq_dist(first_i, last_i, points)
        index = result.index

        if result.max_sq_dist > sq_tolerance
          points[index].keep = true

          stack.push(first_i, index, index, last_i)
        end

        first_i, last_i = stack.pop(2)
      end

      points
    end

    def calc_max_sq_dist(first_i, last_i, points)
      index = nil
      max_sq_dist = 0
      range = (first_i + 1)...last_i

      range.each do |i|
        sq_dist = get_sq_seg_dist(points[i], points[first_i], points[last_i])

        if sq_dist > max_sq_dist
          index = i
          max_sq_dist = sq_dist
        end
      end

      MaxSqDist.new(max_sq_dist, index)
    end

    # Square distance from a point to a segment
    def get_sq_seg_dist(point, point_1, point_2)
      x  = point_1.x
      y  = point_1.y
      dx = point_2.x - x
      dy = point_2.y - y

      if dx != 0 || dy != 0
        t = ((point.x - x) * dx + (point.y - y) * dy) / (dx * dx + dy * dy)

        if t > 1
          x = point_2.x
          y = point_2.y

        elsif t > 0
          x += dx * t
          y += dy * t
        end
      end

      dx = point.x - x
      dy = point.y - y

      dx * dx + dy * dy
    end
  end
end
