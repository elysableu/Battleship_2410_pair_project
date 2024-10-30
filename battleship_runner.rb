# Main Menu
  puts "Welcome to BATTLESHIP!"
  puts "Enter p to play. Enter q to quit."
  input = gets.chomp

# Determine outcome based on player input
  if input == "p"
    # Create new game
    # game = Game.new()

    # Setup Game
    # game.comp_setup()

    puts  "I have laid out my ships on the grid. \n" +
          "You now need to lay out your two ships. \n" +
          "The Cruiser is three units long and the Submarine is two units long."
    # game.player_board.render(true)
    puts  "Enter the squares for the Cruiser (3 spaces): \n>"
    cruiser_location = gets.chomp
    ## Add helper method that changes location from string to array
    # game.player_board.place("Cruiser", cruiser_location)
    #game.player_board.render(true)

    puts  "Enter the squares for the Submarine (2 spaces): \n>"
    submarine_location = gets.chomp
    ## Add helper method that changes location from string to array
    # game.player_board.place("Submarine", submarine_location)
    #game.player_board.render(true)
    ## Add line in render to display invalid placement message

    # Start game
    # game.start
    ## Handle end game message in game class
  else
    puts "Too bad!"
  end