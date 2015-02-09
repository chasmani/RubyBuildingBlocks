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
		result = []
		self.my_each do |i|
			if yield(i) == true
				result << i
			end
		end
		result
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

	def my_map_with_block(&block)
		#Works only with block
		result = []
		self.my_each do |element|
			result << yield(element)
		end
		result
	end

	def my_map_with_proc(proc)
		#Works only with proc
		result = []
		self.my_each do |element|
			result << proc.call(element)
		end
		result
	end

	def my_map(proc=nil, &block)
		#Works with any combination given
		#If block and proc - both applied
		#if nothing given - return enumerable
		if proc && !block_given?	
			result = self.my_map_with_proc(proc)			
		elsif !proc && block_given?
			result = self.my_map_with_block(&block)
		elsif proc && block_given?
			result = self.my_map_with_proc(proc)			
			result = result.my_map_with_block(&block)
		elsif !proc && !block_given?
			result = self.to_enum
		end
		result
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

puts "\n---------my_map_with_block tests ------------"
puts "Expect NAME! once per line - "
puts names.my_map_with_block {|x| x + "!"}

puts "Expect numbers squared, once per line, 1,4,9,16,25"
puts numbers.my_map_with_block {|x| x**2}

puts "\n-----------my_map_with_proc tests------------------"
exclaim_proc = Proc.new {|x| x + "!"}
puts "Expect NAME! once per line - "
puts names.my_map_with_proc(exclaim_proc)

square = Proc.new {|i| i**2}
puts "Expect numbers squared, once per line, 1,4,9,16,25"
puts numbers.my_map_with_proc(square)

puts "\n-----------my_map tests------------------"
puts "Expect numbers squared, once per line, 1,4,9,16,25"
puts numbers.my_map(square)

puts "Expect numbers squared plus 5, once per line, 6,9,14,21,30"
puts numbers.my_map(square) {|x| x+5}

puts "Expect NAME! once per line - "
puts names.my_map {|x| x + "!"}

puts "Expect Enumerable returned"
puts names.my_map