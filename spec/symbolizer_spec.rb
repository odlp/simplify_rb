require 'spec_helper'
require 'simplify_rb/symbolizer'

describe SimplifyRbUtils::Symbolizer do
  describe '#keys_are_symbols?' do
    it 'returns false if any key is not a Symbol' do
      expect(subject.keys_are_symbols?([:a, 'b', :c])).to equal(false)
    end

    it 'returns return true if all the keys are Symbols' do
      expect(subject.keys_are_symbols?([:a, :b, :c])).to equal(true)
    end
  end

  describe '#symbolize_keys' do
    it 'converts all of the collection\'s keys to symbols' do
      collection = [{ 'a' => 1, 'b' => 2 }, { 'c' => 3 }]
      symbolized_result = subject.symbolize_keys(collection)
      expected_result = [{ a: 1, b: 2 }, { c: 3 }]

      expect(symbolized_result).to eq(expected_result)
    end
  end
end
