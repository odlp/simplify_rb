require 'simplify_rb/version'
require 'simplify_rb/symbolizer'

class SimplifyRb

  def self.simplify(points, tolerance = 1, highest_quality = false)
    raise ArgumentError.new('Points must be an array') unless points.is_a? Array

    return points if points.length <= 1

    symbolizer = SimplifyRbUtils::Symbolizer.new

    points = symbolizer.symbolize_keys(points) unless points.all? { |p| symbolizer.keys_are_symbols?(p.keys) }

    sq_tolerance = tolerance * tolerance

    # Optimisation step 1
    points = simplify_radial_dist(points, sq_tolerance) unless highest_quality

    # Optimisation step 2
    simplify_douglas_peucker(points, sq_tolerance)
  end

  # Basic distance-based simplification
  def self.simplify_radial_dist(points, sq_tolerance)
    new_points = [points.first]

    points.each do |point|
      new_points << point if (get_sq_dist(point, new_points.last) > sq_tolerance)
    end

    new_points << points.last unless new_points.last == points.last

    new_points
  end

  # Simplification using optimized Douglas-Peucker algorithm with recursion elimination
  def self.simplify_douglas_peucker(points, sq_tolerance)
    first = 0
    last  = points.length - 1
    index = nil
    stack = []

    points.first[:keep] = true
    points.last[:keep]  = true

    while last
      max_sq_dist = 0

      ((first + 1)...last).each do |i|
        sq_dist = get_sq_seg_dist(points[i], points[first], points[last])

        if sq_dist > max_sq_dist
          index = i
          max_sq_dist = sq_dist
        end
      end

      if max_sq_dist > sq_tolerance
        points[index][:keep] = true

        stack.push(first, index, index, last)
      end

      first, last = stack.pop(2)
    end # end while

    points.select { |p| p[:keep] && p.delete(:keep) }
  end

  # Square distance between two points
  def self.get_sq_dist(point_1, point_2)
    dx = point_1[:x] - point_2[:x]
    dy = point_1[:y] - point_2[:y]

    dx * dx + dy * dy
  end

  # Square distance from a point to a segment
  def self.get_sq_seg_dist(point, point_1, point_2)
    x  = point_1[:x]
    y  = point_1[:y]
    dx = point_2[:x] - x
    dy = point_2[:y] - y

    if dx != 0 || dy != 0
      t = ((point[:x] - x) * dx + (point[:y] - y) * dy) / (dx * dx + dy * dy)

      if t > 1
        x = point_2[:x]
        y = point_2[:y]

      elsif t > 0
        x += dx * t
        y += dy * t
      end
    end

    dx = point[:x] - x
    dy = point[:y] - y

    dx * dx + dy * dy
  end
end
