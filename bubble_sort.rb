def bubble_sort(array)
#Loops through array, switching biggest numebr to the right
#Sets last number as biggest, loops through array again.

	#Loop as long as the array is (-1)
	(array.length-1).times do
		#Loop through each item in the array
		array.each_with_index do |variable, index|

			#Don't do the comparison on last element
			if index < (array.length-1)
				
				#Compare next_element and switch if it's bigger
				next_variable = array[index+1]
				if ( variable <=> next_variable) == 1
					array[index] = next_variable
					array[index+1]=variable
					
				end
				p array
			end
			
		end
	end
end

simple_array = [1,4,5,2,7,3,8]
backwards_array = [5,4,3,2,1]

bubble_sort(backwards_array)
