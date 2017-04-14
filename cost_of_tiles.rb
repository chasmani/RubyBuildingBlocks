def number_of_tiles(width, height, cost)
	width*height*cost
end

puts "What is the width of the floor?"
width = gets.chomp.to_i
puts "What is the height of the floor?"
height = gets.chomp.to_i
puts "What is the cost per square unit of floor tiles?"
cost = gets.chomp.to_i

puts number_of_tiles(width, height, cost)