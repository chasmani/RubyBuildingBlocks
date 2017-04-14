# Determines whether a number is a happy number or not
def happy_number(number, happy_history=[])

	happy_history << number
	#Check if number is 1, in which case it's a happy number
	if number == 1
		return "Happy Number"
	end

	#Convert number to sum of it's digits squared
	number = sum_of_digit_squares(number)

	#Check if the new number has appeared before
	if happy_history.include?(number)
		return "Sad Number"
	end
		
	# Recursion
	happy_number(number, happy_history)
		
end

# Returns sum of the digits of a number squared
def sum_of_digit_squares(number)
	digits = number.to_s.split(//)
	sum = 0
	digits.each do |digit|
		sum += (digit.to_i)**2
	end
	sum
end

# Gives a sequence of the first happy numbers of a given length
def happy_number_sequence(length)

	happy_sequence=[]
	i=1
	while happy_sequence.length < length
		if happy_number(i) == "Happy Number"
			happy_sequence << i	
		end
		i += 1
	end
	happy_sequence
end

puts happy_number_sequence(8)