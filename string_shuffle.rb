# Shuffle a string
#split shuffle join

def shuffle(string)
	string.split(//).shuffle.join
end

puts shuffle("Hello")