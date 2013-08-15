class Numeric
	# In $/currency
  @@currencies = {'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019, 'dollar' => 1}
  def method_missing(method_id)
    singular_currency = method_id.to_s.gsub( /s$/, '')
    if @@currencies.has_key?(singular_currency)
      self * @@currencies[singular_currency]
    else
      super
    end
  end
	
	def in (currency_symbol)
		singular_currency = currency_symbol.to_s.gsub( /s$/, '')
		return self / @@currencies[singular_currency]
	end
end

class String
  def palindrome?
		str = self.gsub(/\W*/, '').downcase
		return true if (str == str.reverse)
		return false
	end
end

module Enumerable
  def palindrome?		
		self.to_a == self.to_a.reverse
	end
end
