module SimplifyRb
  class Point
    attr_reader :x, :y, :original_entity
    attr_accessor :keep

    def initialize(raw_point)
      @original_entity = raw_point
      @x, @y = parse_x_y(raw_point)
    end

    def get_sq_dist_to(other_point)
      dx = x - other_point.x
      dy = y - other_point.y

      dx * dx + dy * dy
    end

    private

    def parse_x_y(raw_point)
      x = nil
      y = nil

      if raw_point.kind_of? Hash
        x = raw_point[:x] || raw_point['x']
        y = raw_point[:y] || raw_point['y']
      elsif raw_point.respond_to?(:x) && raw_point.respond_to?(:y)
        x = raw_point.x
        y = raw_point.y
      end

      if x.nil? || y.nil?
        raise ArgumentError.new('Points must have :x and :y values')
      end

      [x, y]
    end
  end
end
