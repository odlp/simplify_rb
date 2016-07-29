module SimplifyRb
  module Symbolize
    def symbolize_keys
      each_pair.each_with_object({}) { |(k,v), memo| memo[k.to_sym] = v }
    end
  end
end
