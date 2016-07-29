# Basic distance-based simplification

module SimplifyRb
  class RadialDistanceSimplifier
    def process(points, sq_tolerance)
      new_points = [points.first]

      points.each do |point|
        sq_dist = point.get_sq_dist_to(new_points.last)
        new_points << point if sq_dist > sq_tolerance
      end

      new_points << points.last unless new_points.last == points.last

      new_points
    end
  end
end
