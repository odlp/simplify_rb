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

    describe 'unexpected argument' do
      it 'raises an error if the points are not passsed as an array' do
        data = { x: 1, y: 2 }
        expect { subject.process(data) }.to raise_error(ArgumentError, 'Points must be an array')
      end
    end
  end

  def fixture_file(name)
    path = File.expand_path("../fixtures/#{name}", __FILE__)
    YAML.load_file(path)
  end
end
