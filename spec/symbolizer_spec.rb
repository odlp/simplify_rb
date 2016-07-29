require 'spec_helper'
require 'simplify_rb/symbolize'

describe SimplifyRb::Symbolize do
  describe '#symbolize_keys' do
    it 'converts all of the hash\'s keys to symbols' do
      collection = { 'a' => 1, 'b' => 2 }
      collection.extend(SimplifyRb::Symbolize)

      symbolized_result = collection.symbolize_keys
      expected_result = { a: 1, b: 2 }

      expect(symbolized_result).to eq(expected_result)
    end
  end
end
