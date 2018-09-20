require 'spec_helper'
require 'simplify_rb'
require 'yaml'

describe SimplifyRb::Simplifier do
  describe '#process' do
    context 'simplifies points correctly with the given tolerance' do
      let(:test_data) { fixture_file('all-points.yml') }
      let(:expected_result_fast) { fixture_file('result-fast.yml') }
      let(:expected_result_high_quality) { fixture_file('result-high-quality.yml') }

      it 'uses the fast strategy by default', focus: true do
        result = subject.process(test_data, 5)
        expect(result).to eq(expected_result_fast)
      end

      it 'uses the high quality strategy when the flag is passed' do
        result = subject.process(test_data, 5, true)
        expect(result).to eq(expected_result_high_quality)
      end
    end

    describe 'extra properties on the data' do
      it 'preserves the extra properties' do
        richer_data = [
          { x: 51.5256, y: -0.0875, note: 'Foo bar' },
          { x: 51.7823, y: -0.0912, attr: 123 }
        ]

        result = subject.process(richer_data, 5, true)

        expect(result.length).to eq 2

        expect(result.first[:note]).to eq 'Foo bar'
        expect(result.last[:attr]).to eq 123
      end
    end

    context 'only one point' do
      it 'returns a list with one point' do
        data = [{ x: 1, y: 2 }]
        expect(subject.process(data)).to eq(data)
      end
    end

    context 'no points' do
      it 'returns an empty list of points' do
        expect(subject.process([])).to be_empty
      end
    end

    describe 'unexpected arguments' do
      context 'when raw_points is not enumerable' do
        it 'raises an ArgumentError' do
          data = Object.new
          expect { subject.process(data) }.to raise_error(ArgumentError, 'raw_points must be enumerable')
        end
      end

      context "when raw_points is enumerable, but doesn't respond to x/y" do
        it 'raises an ArgumentError' do
          data = [{ foo: :bar }, { foo: :bar }]
          expect { subject.process(data) }.to raise_error(ArgumentError, 'Points must have :x and :y values')
        end
      end
    end
  end

  def fixture_file(name)
    path = File.expand_path("../fixtures/#{name}", __FILE__)
    YAML.load_file(path)
  end
end
