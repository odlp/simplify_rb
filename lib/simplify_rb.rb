require "simplify_rb/version"

class SimplifyRb
  # Main method
  def self.simplify (points, tolerance=1, highest_quality=false)
    return points if points.length <= 1

    points = symbolize_keys(points) unless keys_are_symbols?(points.map{|p| p.keys})

    sq_tolerance = tolerance * tolerance
  
    # Optimisation step 1
    points = simplifyRadialDist(points, sq_tolerance) unless highest_quality
    
    # Optimisation step 2
    simplifyDouglasPeucker(points, sq_tolerance)
  end

  # Basic distance-based simplification
  def self.simplifyRadialDist (points, sq_tolerance)
    new_points = [points.first]

    points.each do |point|
      new_points << point if (getSqDist(point, new_points.last) > sq_tolerance)
    end

    new_points << points.last unless new_points.last == points.last

    new_points
  end

  # Simplification using optimized Douglas-Peucker algorithm with recursion elimination
  def self.simplifyDouglasPeucker (points, sq_tolerance)
    length  = points.length
    first   = 0
    last    = length - 1
    index   = nil
    stack   = []

    points.first[:keep] = true
    points.last[:keep]  = true

    while last do
      max_sq_dist = 0

      ((first + 1)...last).each do |i|
        sq_dist = getSqSegDist(points[i], points[first], points[last])

        if sq_dist > max_sq_dist
          index = i
          max_sq_dist = sq_dist
        end
      end

      if max_sq_dist > sq_tolerance
        points[index][:keep] = true

        stack.push(first, index, index, last)
      end

      last  = stack.pop
      first = stack.pop

    end # end while

    points.keep_if { |p| p[:keep] && p.delete(:keep) }
  end

  # Square distance between two points
  def self.getSqDist (point_1, point_2)
    dx = point_1[:x] - point_2[:x]
    dy = point_1[:y] - point_2[:y]

    dx * dx + dy * dy
  end

  # Square distance from a point to a segment
  def self.getSqSegDist (point, point_1, point_2)
    x  = point_1[:x]
    y  = point_1[:y]
    dx = point_2[:x] - x
    dy = point_2[:y] - y

    if (dx != 0 || dy != 0)
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

  # Check if keys are symbols
  def self.keys_are_symbols? (keys)
    keys.all? {|k| k.is_a? Symbol}
  end

  # Symbolize all the hash keys in an array of hashes
  def self.symbolize_keys (collection)
    collection.map do |item|
      item.each_with_object({}) { |(k,v), memo| memo[k.to_sym] = v }
    end
  end
end
