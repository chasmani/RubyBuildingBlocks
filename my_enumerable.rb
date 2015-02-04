module Enumerable
	def my_each
		self.length.times do |i|
			yield(self[i])
		end
	end

	def my_each_with_index
		self.length.times do |i|
			yield(self[i], i)
		end
	end

	def my_select
		new_array = []
		self.my_each do |i|
			if yield(i) == true
				new_array << i
			end
		end
		new_array
	end

	def my_all?

		result = true
		self.my_each do |element|
			if yield(element) == false
				result = false
			end
		end
		result
	end

	def my_any?

		result = false
		self.my_each do |element|
			if yield(element) == true
				result = true
			end
		end
		result
	end

	def my_none?

		result = true
		self.my_each do |element|
			if yield(element) == true
				result = false
			end
		end
		result
	end

	def my_count(&block)
		#Works only with block

		count=0
		
		self.my_each do |element|
				count += 1 if block.call(element)
		end
		
		count
	end

	def my_map(&block)
		#Works only with block
		new_array = []
		self.my_each do |element|
			new_array << yield(element)
		end
		new_array
	end

	def my_collect(&block)
		my_map(&block)
	end

	def my_inject(arg, &block)
		result=arg
		self.my_each do |element|
			result =  yield(result, element)
		end
		result
	end

	
end

def multiply_els(array)
	array.my_inject(1) {|result, element| result * element}
end


numbers = [1,2,3,4,5]
names = ["Bob", "Jim", "Alex", "Charlie"]
mixed = ["John", 7, "Axle", 21, 2, "Janice", "Bo"]


puts "--------my_each tests-----------"
puts "Expect 12345: "
numbers.my_each {|i| print i}
puts "\nExpect Hello NAME, one per line"
names.my_each {|name| puts "Hello #{name}"}

puts "\n--------my each with index tests ------"
puts "Expect Hello NAME you are INDEX in the queue, one per line"
names.my_each_with_index {|name, index| puts "Hello #{name} you are #{index} in the queue"}


puts "\n--------my_select tests---------_"
puts "Expect names of length 3 - "
puts names.my_select {|i| i.length == 3}

puts "\nExpect numbers above 3 - \n"
puts numbers.my_select {|i| i > 3}

puts "\n---------my_all? tests------------_"

puts "Expect FALSE - "
puts names.my_all? {|i| i.is_a? Fixnum}

puts "\nExpect TRUE - "
puts numbers.my_all? {|i| i > 0}

puts "\n---------my_any? tests ------------"
puts "Expect FALSE"
puts numbers.my_any? {|i| i == 10 }

puts "\n---------my_none? tests -----------"
puts "Expect false - "
puts numbers.my_none? {|i| i == 5 }

puts "\n---------my_count tests -----------"
puts "Expect 1 - "
puts names.my_count {|i| i == "Bob"}

puts "\nExpect 3 - "
puts numbers.my_count {|i| i <4}

#puts"\nExpect 2 - "
#puts mixed.my_count {|i| i > 5}

puts "\n---------my_map tests ------------"
puts "Expect NAME! once per line - "
puts names.my_map {|x| x + "!"}

puts "Expect numbers squared, once per line, 1,4,9,16,25"
puts numbers.my_map {|x| x**2}

puts "\n---------my_collect tests-------"
puts "Expect NAME! once per line - "
puts names.my_collect {|x| x + "!"}

puts "Expect numbers squared, once per line, 1,4,9,16,25"
puts numbers.my_collect {|x| x**2}

puts "\n----------my_inject tests--------"
puts "Expect 15 - "
puts numbers.my_inject(0) {|result, element| result + element}


puts "Expect a hash for Shane Harvie"
hash = [[:first_name, 'Shane'], [:last_name, 'Harvie']].my_inject({}) do |result, element|
  result[element.first] = element.last
  result
end
puts hash

puts "Expect an array of 2,4,6"
array = [1, 2, 3, 4, 5, 6].my_inject([]) do |result, element|
  result << element.to_s if element % 2 == 0
  result
end
puts array 

puts "\n----------multiply_els tests --------------"
puts "Expect 40 - "
puts multiply_els([2,4,5])

puts "Expect 120 - "
puts multiply_els(numbers)

puts "\n-----------my_map proc------------------"