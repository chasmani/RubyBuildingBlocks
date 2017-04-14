# Sets up and plays one game of mastermind between a codemaker and codebreaker
class Game

	attr_accessor :turns
	attr_reader :colours_available, :codemaker, :codebreaker, :game_length

	def initialize
		@turns = 0
		@game_length = 12
		@colours_available = ["Red", "Blue", "Black", "White", "Yellow", "Pink"]
		create_cpu_codemaker
		create_cpu_codebreaker
		game_loop
	end

	def select_codemaker
		response = nil
		while !((response == "cpu") || (response =="human"))
			puts "Do you want the code to be set by a cpu or human?"
			puts "Please type 'cpu' or 'human'"
			response = gets.chomp.downcase
		end
		if response == "cpu"
			create_cpu_codemaker
		elsif response == "human"
			create_human_codemaker
		end
				

	end

	def create_human_codemaker
		@codemaker = HumanCodemaker.new(colours_available)
	end

	def create_cpu_codemaker
		@codemaker = CPUCodemaker.new(colours_available)
	end

	def create_human_codebreaker
		@codebreaker = HumanCodebreaker.new(colours_available)
	end

	def create_cpu_codebreaker
		@codebreaker = CPUCodeBreaker.new(colours_available)
	end

	# Plays the game, handling the guesses and responses
	def game_loop
		game_over = nil
		while game_over == nil
			guess = get_codebreaker_guess
			game_over ||= check_guess?(guess)
			
			@turns += 1
			game_over ||= out_of_turns?
		end
	end

	def get_codebreaker_guess
		codebreaker.make_guess
	end

	def send_feedback_to_codebreaker(guess_result)

	end


	# Checks to see if the code is correct
	def check_guess?(guess)
		guessed_correctly = nil
		guess_result = codemaker.check_guess(guess)
		puts "Red pegs - #{guess_result[:red_pegs]}"
		puts "White pegs - #{guess_result[:white_pegs]}"
		if guess_result[:red_pegs] == 4
			puts "Whoa you guessed the code!"
			guessed_correctly = true
		end
		send_feedback_to_codebreaker(guess_result)
		guessed_correctly
	end

	# Checks to see if turns are finished
	def out_of_turns?
		out_of_turns = nil
		puts "#{turns} out of #{game_length} turns played}"
		if turns >= game_length
			out_of_turns = true
		end
		out_of_turns
	end

end

# The base code maker class, that responds to guesses
class Codemaker

	attr_reader :code


	# Set a code
	def code=(code)
		@code = code
	end

	# Return the result of a guess
	def check_guess(guess)
		
		# red pegs equal to number in correct position
		red_pegs = check_correct_positions(guess)

		# white pegs to correct colours minus correct positions
		white_pegs = check_correct_colours(guess) - red_pegs

		{:red_pegs => red_pegs, :white_pegs => white_pegs}
	end

	# Check how many colours are in the correct position
	def check_correct_positions(guess)
		correct_positions = 0
		guess.each_with_index do |guess_peg, index|
			if code[index] == guess_peg
				correct_positions += 1
			end
		end
		correct_positions
	end

	# Check how many colours are correct
	def check_correct_colours(guess)
		correct_colours = 0
		code.each do |code_peg|
			if guess.include? code_peg
				guess.delete_at(guess.find_index(code_peg))
				correct_colours += 1
			end
		end
		correct_colours
	end

end

# The CPU codemaker extends codemaker and also generates a random code
class CPUCodemaker < Codemaker


	# Initialize the code
	def initialize(colours_available)
		@code = set_random_code(colours_available)	
	end

	# Return a random code 
	def set_random_code(colours_available)	
		code =[]
		4.times do
			code << colours_available.sample
		end
		code
	end
end

# Handles interactions with the user - getting element details
module UserInteractions	

	def get_element(colours_available, element)
		validate_element(colours_available) do
			print "Number #{element} - " 
			gets.chomp
		end
	end

	def validate_element(colours_available, &block)
		element_guess = yield
		while !(colours_available.include? element_guess) do
			puts "You have to pick a valid choice, one of #{colours_available}"
			element_guess = yield
		end
		element_guess
	end

end

# Plays as a human codemaker, sets the code for setting the code
# Extends Codemaker, adds methods to have a human set the code
class HumanCodemaker < Codemaker

	include UserInteractions

	# Initialize the code
	def initialize(colours_available)
		@code = set_user_code(colours_available)	
	end

	def set_user_code(colours_available)
		code = []
		puts "Make a selection punk"
		4.times do |element|
			code << get_element(colours_available, element + 1)
		end
		code
	end

end

#Plays as a random CPU player, guessing at random. 
class CPUCodeBreaker

	attr_reader :colours_available

	def initialize(colours_available)
		@colours_available = colours_available
	end

	def make_guess
		random_guess
	end

	def random_guess
		guess =[]
		4.times do
			guess << colours_available.sample
		end
		puts "Guess - #{guess}"
		guess
	end	

end

class AICodebreaker

	attr_reader :colours_available, :possible_codes
	attr_reader :tester, :guess

	def initialize(colours_available)
		@colours_available = colours_available
		@guess = first_guess
		create_test_codemaker_bot
		@possible_codes = create_possible_codes
	end

	def first_guess
		[colours_available[0], colours_available[0], colours_available[1], colours_available[1]]
	end

	def create_possible_codes
		possible_codes = []
		colours_available.each do |colour1|
			colours_available.each do |colour2|
				colours_available.each do |colour3|
					colours_available.each do |colour4|
						possible_codes << [colour1, colour2, colour3, colour4]
					end
				end
			end
		end
		possible_codes
	end

	def create_test_codemaker_bot
		@tester = Codemaker.new
	end

	# Check what resut a guess would create against a generated code 
	# This returns a hash
	def check_result_of_guess(code, guess)
		# 1. Set the code
		tester.code=code
		# 2. Check the guess
		tester.check_guess(guess)
	end

	# Narrows down the possible codes based on the feedback from the guess
	def narrow_down(feedback)
		p guess
		new_possible_codes = []
		possible_codes.each do |code|
			p code
			p @guess
			puts check_result_of_guess(code, guess)
			p "HELLOO"
			p @guess
			if check_result_of_guess(code, guess) == feedback
				puts "added"
				new_possible_codes << code
			end
		end
		new_possible_codes
		end



end



# Plays as a human code breaker, makes guesses for the code
class HumanCodebreaker

	include UserInteractions

	attr_reader :colours_available

	def initialize(colours_available)
		@colours_available = colours_available
	end

	# Makes a guess of the code
	def make_guess
		guess = []
		puts "Make a guess punk"
		4.times do |element|
			guess << get_element(colours_available, element + 1)
		end
		guess
	end

end

colours = ["Red", "White", "Yellow", "Black", "Blue", "Pink"]

# Make a new codemaker
codemaker = CPUCodemaker.new(colours)
p codemaker.code

# Make an AI codebreaker
comp = AICodebreaker.new(colours)
p comp.create_possible_codes.length
p comp.guess

# Make the first guess
guess = ["Red", "Red","White","White"]
p guess

# Get feedback of the first guess
feedback = codemaker.check_guess(guess)

p comp.narrow_down(feedback).length


'''


comp = CPUCodeBreaker.new(colours)
p comp.make_guess





codemaker = Codemaker.new(colours)

p codemaker.code
codemaker.code = (["Blue", "Blue", "Red", "Pink"])
p codemaker.check_correct_positions(["Blue", "White", "Red", "Pink"])
p codemaker.check_correct_colours(["Blue", "White", "Red", "Pink"])
p codemaker.check_guess(["Blue", "White", "Blue", "Blue"])
'''