require 'spec_helper'
require 'simplify_rb/point'

describe SimplifyRb::Point do
  describe 'parsing hashes with string keys' do
    it 'determines the :x, :y value' do
      raw_point = { "x" => 51.5256, "y" => -0.0875 }
      point = described_class.new(raw_point)

      expect(point.x).to eq(51.5256)
      expect(point.y).to eq(-0.0875)
    end
  end

  describe 'parsing structs' do
    it 'determines the :x, :y value' do
      CustomPointStruct = Struct.new(:x, :y)
      raw_point = CustomPointStruct.new(51.5256, -0.0875)

      point = described_class.new(raw_point)

      expect(point.x).to eq(51.5256)
      expect(point.y).to eq(-0.0875)
    end
  end

  describe 'handling raw points which are objects' do
    it 'determines the :x, :y value' do
      class MyCustomPoint
        attr_reader :x, :y

        def initialize(x, y)
          @x = x
          @y = y
        end
      end

      raw_point = MyCustomPoint.new(51.5256, -0.0875)

      point = described_class.new(raw_point)

      expect(point.x).to eq(51.5256)
      expect(point.y).to eq(-0.0875)
    end
  end

  describe 'missing x/y values' do
    it 'raises an error if the points are missing keys' do
      invalid_point = { Z: 51.5256, y: -0.0875 }
      expect { described_class.new(invalid_point) }.to raise_error(ArgumentError, 'Points must have :x and :y values')

      invalid_point = { x: 51.5256, Z: -0.0875 }
      expect { described_class.new(invalid_point) }.to raise_error(ArgumentError, 'Points must have :x and :y values')
    end

    it 'raises an error if points don\'t respond to x / y' do
      class UnconventialPoint
        attr_reader :a, :b

        def initialize(a, b)
          @a = a
          @b = b
        end
      end

      invalid_point = UnconventialPoint.new(51.5256, -0.0875)
      expect { described_class.new(invalid_point) }.to raise_error(ArgumentError, 'Points must have :x and :y values')
    end
  end
end
