require 'simplify_rb/symbolize'

module SimplifyRb
  class Point
    attr_reader :x, :y, :original_entity
    attr_accessor :keep

    def initialize(raw_point)
      @original_entity = raw_point
      sym_hsh = raw_point.extend(Symbolize).symbolize_keys

      @x = sym_hsh[:x]
      @y = sym_hsh[:y]
    end

    def get_sq_dist_to(other_point)
      dx = x - other_point.x
      dy = y - other_point.y

      dx * dx + dy * dy
    end
  end
end
