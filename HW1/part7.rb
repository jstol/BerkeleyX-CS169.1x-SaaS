class CartesianProduct
  include Enumerable
  def initialize (seq1, seq2)
		@seq1 = seq1
		@seq2 = seq2
		@product = Array.new
		if (!seq1.empty? and !seq2.empty?)
			seq1.each do |element1|
				seq2.each do |element2|
					@product.push [element1, element2]
				end
			end
		end
	end
	
	def each
		return nil if @product.empty?
		@product.each do |pair|
			yield (pair)
		end
	end
end