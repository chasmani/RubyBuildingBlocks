#Substrings
#Finds number of occurences of a dictionary of words in a string
#Returns results in a hash of format :word => :occurences

def substrings(string, dictionary)
	
	results_hash={}

	#Scan each word and add it to the results hash if it appears
	dictionary.each do |word|
		occurences = string.downcase.scan(word).length 
		results_hash[word] = occurences if occurences > 0
	end
	puts results_hash	
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
substrings("below", dictionary)
substrings("Howdy partner, sit down! How's it going?", dictionary)