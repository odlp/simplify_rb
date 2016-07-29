require 'spec_helper'
require 'simplify_rb'
require File.expand_path('../fixtures/simplify_test_data.rb', __FILE__)

describe SimplifyRb do
  describe '#simplify' do
    context 'simplifies points correctly with the given tolerance' do
      let(:test_data) { SimplifyTestData::points }
      let(:expected_fast_result) { SimplifyTestData::result_fast }
      let(:expected_high_quality_result) { SimplifyTestData::result_high_quality }

      it 'uses the fast strategy by default' do
        result = SimplifyRb.simplify(test_data, 5)
        expect(result).to eq(expected_fast_result)
      end

      it 'uses the high quality strategy when the flag is passed' do
        result = SimplifyRb.simplify(test_data, 5, true)
        expect(result).to eq(expected_high_quality_result)
      end
    end

    context 'only one point' do
      it 'returns a list with one point' do
        data = [{ x: 1, y: 2 }]
        expect(SimplifyRb.simplify(data)).to eq(data)
      end
    end

    context 'no points' do
      it 'returns an empty list of points' do
        expect(SimplifyRb.simplify([])).to be_empty
      end
    end

    describe 'unexpected argument' do
      it 'raises an error if the points are not passsed as an array' do
        data = { x: 1, y: 2 }
        expect { SimplifyRb.simplify(data) }.to raise_error(ArgumentError, 'Points must be an array')
      end
    end
  end
end
