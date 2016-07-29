require 'simplify_rb/symbolize'

module SimplifyRb
  class Point

    attr_reader :x, :y
    attr_accessor :keep

    def initialize(raw_hsh)
      sym_hsh = raw_hsh.extend(Symbolize).symbolize_keys

      @x = sym_hsh[:x]
      @y = sym_hsh[:y]
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
