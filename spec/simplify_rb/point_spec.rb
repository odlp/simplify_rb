require "simplify_rb/point"

RSpec.describe SimplifyRb::Point do
  describe "parsing hashes with string keys" do
    it "determines the :x, :y value" do
      raw_point = {"x" => 51.5256, "y" => -0.0875}
      point = described_class.new(raw_point)

      expect(point.x).to eq(51.5256)
      expect(point.y).to eq(-0.0875)
    end
  end

  describe "parsing structs" do
    it "determines the :x, :y value" do
      custom_point_struct = Struct.new(:x, :y)
      raw_point = custom_point_struct.new(51.5256, -0.0875)

      point = described_class.new(raw_point)

      expect(point.x).to eq(51.5256)
      expect(point.y).to eq(-0.0875)
    end
  end

  describe "handling raw points which are objects" do
    it "determines the :x, :y value" do
      my_custom_point = define_class("MyCustomPoint") do
        attr_reader :x, :y

        def initialize(x, y)
          @x = x
          @y = y
        end
      end

      raw_point = my_custom_point.new(51.5256, -0.0875)

      point = described_class.new(raw_point)

      expect(point.x).to eq(51.5256)
      expect(point.y).to eq(-0.0875)
    end
  end

  describe "missing x/y values" do
    it "raises an error if the points are missing keys" do
      invalid_point = {Z: 51.5256, y: -0.0875}
      expect { described_class.new(invalid_point) }.to raise_error(ArgumentError, "Points must have :x and :y values")

      invalid_point = {x: 51.5256, Z: -0.0875}
      expect { described_class.new(invalid_point) }.to raise_error(ArgumentError, "Points must have :x and :y values")
    end

    it "raises an error if points don't respond to x / y" do
      unconvention_point = define_class("UnconventionPoint") do
        attr_reader :a, :b

        def initialize(a, b)
          @a = a
          @b = b
        end
      end

      invalid_point = unconvention_point.new(51.5256, -0.0875)
      expect { described_class.new(invalid_point) }.to raise_error(ArgumentError, "Points must have :x and :y values")
    end
  end

  private

  def define_class(name, &block)
    const = stub_const(name, Class.new)
    const.class_eval(&block) if block_given?
    const
  end
end
