require 'simplify_rb/symbolizer'

module SimplifyRb
  class Point
    attr_reader :x, :y
    attr_accessor :keep

    def initialize(point_hash)
      unless Symbolizer.new.keys_are_symbols?(point_hash.keys)
        point_hash = Symbolizer.new.symbolize_keys(point_hash)
      end

      @x = point_hash[:x]
      @y = point_hash[:y]
    end

    def to_h
      { x: x, y: y }
    end

    def get_sq_dist_to(other_point)
      dx = x - other_point.x
      dy = y - other_point.y

      dx * dx + dy * dy
    end
  end
end
