#For those just starting out, one suggested way to work on your code is to have a command window open and a text editor with this
#file loaded.  Make changes to this file and then run 'ruby part1.rb' at the command line, this will run your program.  Once you're
#satisfied with your work, save your file and upload it to the checker.


def palindrome?(str)
  str = str.gsub(/\W*/, '').downcase
  return true if (str == str.reverse)
  return false
end

def count_words(str)
  str = str.downcase
  str_array = str.split(/\s+|\b/)
  word_count = {}
  str_array.each do |word|
	if word_count[word]
		word_count[word] = word_count[word].next
	else	
		word_count[word] = 1
	end
  end
  return word_count
end
