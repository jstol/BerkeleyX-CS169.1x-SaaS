def combine_anagrams(words)
 anagram_dictionary = {}
 words.each do |word|
	sorted_word = word.downcase.split('').sort.join('')
	puts sorted_word
	if (anagram_dictionary[sorted_word])
		anagram_dictionary[sorted_word].push(word)
	else
		anagram_dictionary[sorted_word] = Array.new
		anagram_dictionary[sorted_word].push(word)
	end
 end
 return anagram_dictionary.values
end

print combine_anagrams ["HeLLo", "hello"]