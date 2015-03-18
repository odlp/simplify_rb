require "spec_helper"

describe SimplifyRb do
  context "simplifies points correctly with the given tolerance" do
    before(:each) {@test_data = SimplifyTestData::points}

    it "uses the fast strategy by default" do
      expect(SimplifyRb.simplify(@test_data, 5)).to eq(SimplifyTestData::result_fast)
    end

    it "uses the high quality strategy when the flag is passed" do
      expect(SimplifyRb.simplify(@test_data, 5, true)).to eq(SimplifyTestData::result_high_quality)
    end
  end

  it "returns the points if it has only one point" do
    data = [{x: 1, y: 2}]

    expect(SimplifyRb.simplify(data)).to eq(data)
  end

  it "returns the array if it has no points" do
    expect(SimplifyRb.simplify([])).to eq([])
  end

  it "raises an argument error if the points are not passsed as an array" do
    data = {x: 1, y: 2}

    expect { SimplifyRb.simplify(data) }.to raise_error(ArgumentError, "Points must be an array")
  end

  describe "#keys_are_symbols?" do
    it "returns false if any key is not a Symbol" do
      expect(SimplifyRb.keys_are_symbols? [:a, 'b', :c]).to equal(false)
    end

    it "returns return true if all the keys are Symbols" do
      expect(SimplifyRb.keys_are_symbols? [:a, :b, :c]).to equal(true)
    end
  end

  describe "#symbolize_keys" do
    it "converts all of the collection's keys to symbols" do
      collection = [{'a' => 1, 'b' => 2}, {'c' => 3}]

      expect(SimplifyRb.symbolize_keys(collection)).to eq([{a: 1, b: 2}, {c: 3}])
    end
  end
end
