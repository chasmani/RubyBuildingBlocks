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
		self.length.times do |i|
			if yield(self[i]) == true
				new_array << self[i]
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

end


numbers = [1,2,3,4,5]
[5,6].my_each {|i| puts i}

names = ["Bob", "Jim", "Alex", "Charlie"]

names.my_each {|name| puts "Hello #{name}"}
names.my_each_with_index {|name, index| puts "Hello #{name} you are #{index} in the queue"}

puts names.my_select {|i| i.length == 3}

puts names.my_all? {|i| i.is_a? Fixnum}
puts numbers.my_all? {|i| i > 0}
puts numbers.my_any? {|i| i == 10 }
puts numbers.my_none? {|i| i == 5 }