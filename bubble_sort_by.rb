def bubble_sort_by(array)
#Loops through array, switching biggest numebr to the right
#Sets last number as biggest, loops through array again.

	#Loop as long as the array is (-1)
	(array.length-1).times do

		#Loop through each item in the array
		array.each_with_index do |variable, index|

			#Don't do the comparison on last element
			if index < (array.length-1)
				
				#Compare next_element and switch if it meets the block condition
				if (yield(array[index], array[index+1])) < 0
					array[index] = array[index+1]
					array[index+1]=variable
					
				end

			end
			
		end
	end
	array
end

word_array = ["Hi", "hello", "hey", "smoky", "Banderas", "O"]

p bubble_sort_by(word_array) { |left, right| right.length - left.length }