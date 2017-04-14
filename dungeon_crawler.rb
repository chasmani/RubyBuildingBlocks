class Dungeon
	attr_accessor :player

 	def initialize(player_name)
 		@player = Player.new(player_name)
 		@rooms = []
 		puts "Legend tells of a deep and dark dungeon that lies in the mountains and holds wonderful treasures and terrible torments for those who dare venture in"
 	end

	def add_room(reference, name, description, connections)
		@rooms << Room.new(reference, name, description, connections)
	end

	def start(location)
		@player.location = location
		puts "You awake with no memory of how you got there.  You look around to get your bearings"
		show_current_description
	end

	def show_current_description
		puts find_room_in_dungeon(@player.location).full_description
	end

	def find_room_in_dungeon(reference)
		@rooms.detect { |room| room.reference == reference}
	end

	def find_room_in_direction(direction)
		find_room_in_dungeon(@player.location).connections[direction]
	end

	def go(direction)
		puts "You go " + direction.to_s
		@player.location = find_room_in_direction(direction)
		show_current_description
	end

	def get_available_directions
		find_room_in_dungeon(@player.location).connections.keys
	end

	class Player
 		attr_accessor :name, :location
 		def initialize(player_name)
 			@name = player_name
 		end
 	end

	class Room
		attr_accessor :reference, :name, :description, :connections

		def initialize(reference, name, description, connections)
			@reference = reference
			@name = name
			@description = description
			@connections = connections
		end

		def full_description
			"\n\nYou are in " + @description
		end
	end
end





# Get the player's name
puts "Welcome challenger - What's your name?"
player_name = gets.chomp

# Create a new dungeon 
my_dungeon = Dungeon.new(player_name)

# Add rooms to the dungeon 
my_dungeon.add_room(:largecave, "Large Cave", "a large cavernous cave", {:west => :smallcave, :south=> :pit})
my_dungeon.add_room(:smallcave, "Small Cave", "a small and tight, moist cave", {:east => :largecave})
my_dungeon.add_room(:pit, "Pit", "a deep dark pit that seems to go on forever", {:north => :largecave})

# Start by placing the player in the dungeon
my_dungeon.start(:largecave)

# Run the game loop
while my_dungeon.player 
	puts "Which way do you want to go?"
	directions = my_dungeon.get_available_directions.join(', ')
	puts "Possible routes - #{directions}"

	direction = gets.chomp.to_sym
	my_dungeon.go(direction)
end