#Caesar Cipher
#Simple text cipher that shifts letters a fixed number of positions

def caesar_cipher(string, shift)
	
	alpha = ("a".."z").to_a
	alphaBig = ("A".."Z").to_a
	new_string = ""
	string.split(//).each do |letter|
		
		if alpha.include? letter
			new_letter = letterShift(letter, alpha, shift)
		elsif alphaBig.include? letter
			new_letter = letterShift(letter, alphaBig, shift)
		else
			new_letter = letter
		end
		new_string += new_letter

	end
	new_string
end

def letterShift(letter, array, shift)

	index = array.index(letter)
	new_index = (index + shift)%(array.length)
	new_letter = array[new_index]
end

##Tests ## 
puts caesar_cipher("What a string!", 5)
puts caesar_cipher("Hello", 0)
puts caesar_cipher("ABCDE_vwxyz@?", 5)
puts caesar_cipher("ABCDEvwxyz", -3)