# Returns either a number split into two factors or the same number
def split_into_2_factors(number)

	factors = []
	max_factor = Math.sqrt(number).to_i

	# Splits a number into 2 factors if it's possible
	(2..max_factor).each do |i|
		if number % i == 0
			factors << i
			factors << number/i
			return factors
		end
	end
	[number]
end

# Splits a number into all of it's prime factors
def split_into_all_factors(number)

	factors = []
	new_factors = [number]

	# Each loop, go through the loop splitting numbers into 2 factors
	# Keep going until the factor list stops growing
	while factors.length!=new_factors.length do
		
		factors = new_factors
		new_factors = []

		factors.each do |i|
			new_factors += split_into_2_factors(i)
		end

	end
	factors
		
end

puts "Hey there, please enter a number"
number = gets.chomp.to_i
puts "Here are the prime factors of #{number}:"
puts split_into_all_factors(number)