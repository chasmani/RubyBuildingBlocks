def fibonacci(number)
	
	fibonacci = []
	number.times do |i|
		if i == 0 || i == 1
			fibonacci << 1
		else
			fibonacci << (fibonacci[i-2] + fibonacci[i-1])
		end
	end
	fibonacci
end

puts "Welcome to the fibonacci generator"
puts "How long a fibonacci sequence do you want?"

length = gets.chomp.to_i

puts fibonacci(length)