# The game class controls the game, initializing the board and players and running the game loop
class Game
	attr_reader :board, :player1, :player2
	attr_accessor :turn

	def initialize
		@board = Board.new
		create_players
		@turn = player1
		game_loop
	end

	# Creates 2 players
	def create_players
		@player1 = Player.new("X")
		@player2 = Player.new("O")
	end

	# Switches turns between the two players
	def switch_turn
		if turn.token == "X"
			@turn = player2
		elsif turn.token == "O"
			@turn = player1
		end
	end

	# The main game loop runs until there is a winner
	def game_loop
		show_board
		game_over = nil
		while !game_over
			#1. Choose position
			position = choose_position(turn)
			#2. Place counter
			place_counter(position, turn)
			#3.Show board
			show_board
			#4. Check game over conditions
			if check_win == "X"
				puts "#{player1.name} is the winner!"
				game_over = true
			elsif check_win == "O"
				puts "#{player2.name} is the winner!"
				game_over = true
			elsif check_draw 
				puts "It's a draw!"
				game_over = true
			end

			#5. Switch players
			switch_turn
		end

	end

	# Asks the player where they want to play 
	def choose_position(player)
		check_answer do
			puts "Hey #{player.name}, where you wanna play?"
			gets.chomp.to_i
		end
	end

	# Checks answer is in an open position
	def check_answer(&block)
		valid = false
		while !valid
			response = yield
			valid = board.open_positions.include? response
			if !valid
				puts "You gotta pick a number that's free - #{board.open_positions}"
			end
		end
		response
	end

	# Place a player token on the board
	def place_counter(position, player)
		board.boxes[position-1].state = player.token
	end

	# Display the board
	def show_board
		puts "\n"
		board.show_board
		puts "\n"
	end

	# Check if there is a winner
	def check_win
		board.win?
	end

	def check_draw
		board.open_positions.empty?
	end

end

# Keeps track of the playing board
class Board
	attr_reader :size, :width
	attr_accessor :boxes

	# All of the possible winning position combinations 
	@@win_combinations = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]

	def initialize(width=3)
		@width = width
		@size = width**2
		@boxes =[]
		create_boxes(size)
	end
	
	# Creates a box object at every position
	def create_boxes(size)
		(width**2).times { |i| new_box(i+1)}
	end

	# Creates a new box object
	def new_box(position)
		box = Box.new(position)
		boxes << box 
	end
	
	# Displays the board
	def show_board
		puts boxes[2*width..size].map{|box| box.state}.join("|")
		puts boxes[width...2*width].map{|box| box.state}.join("|")
		puts boxes[0...width].map{|box| box.state}.join("|")
	end

	# Checks if the win conidtion is met
	def win?
		x_positions = collect_positions("X")
		o_positions = collect_positions("O")
		@@win_combinations.each do |combination|
			if (combination - x_positions).empty?
				return "X"
			elsif (combination - o_positions).empty?
				return "O"
			end	
		end
		nil
	end

	# Returns the positions of the board that are still free
	def open_positions
		[1,2,3,4,5,6,7,8,9] - collect_positions(["X", "O"])
	end

	# Collects positions of player tokens 
	def collect_positions(tokens)
		boxes.select{|box| tokens.include? box.state.to_s }.map {|box| box.position}
	end


end

# Holds the state and position of each box on the board.
class Box
	attr_accessor :state, :position

	def initialize(position)
		@position = position
		@state = position
	end

end

# Holds the name and token type of each player
class Player

	attr_reader :name, :token

	def initialize(token)
		@token = token
		new_name
	end

	def new_name
		puts "Player #{token} - What's your name brother?"
		@name = gets.chomp
	end


end

game = Game.new