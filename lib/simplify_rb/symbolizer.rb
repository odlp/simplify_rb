module SimplifyRbUtils
  class Symbolizer
    def keys_are_symbols?(keys)
      keys.all? { |k| k.is_a? Symbol }
    end

    def symbolize_keys(collection)
      collection.map do |item|
        item.each_with_object({}) { |(k,v), memo| memo[k.to_sym] = v }
      end
    end
  end
end
