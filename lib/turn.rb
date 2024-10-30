class Turn
  attr_reader :player_fired, 
              :player_board, 
              :computer_board, 
              :player_result, 
              :computer_result

  def initialize(player_fired, player_board, computer_board)
    @player_fired = player_fired
    @player_board = player_board
    @computer_board = computer_board
    @player_result = ""
    @computer_result = ""
  end

  def display
    "==========COMPUTER BOARD==========\n" +
    @computer_board.render +
    "\n===========PLAYER BOARD===========\n" +
    @player_board.render(true)
  end
   
  def player_fire_shot
    if @computer_board.cells[@player_fired].fired_upon? == false
      @computer_board.cells[@player_fired].fire_upon
      if @computer_board.cells[@player_fired].empty? == false
        ship = @computer_board.cells[@player_fired].ship
        if ship.health != 0
          @player_result = "Hit"
          return true
        else
          @player_result = "Sunk"
          return true
        end
      else
        @player_result = "Miss"
        return true
      end
    else 
      @player_result = "Player Invalid"
      return false
    end
  end

  def computer_fire_shot 
    computer_fired = random_coordinate
    if @player_board.cells[computer_fired].fired_upon? == false
      @player_board.cells[computer_fired].fire_upon
      if @player_board.cells[computer_fired].empty? == false
        ship = @player_board.cells[computer_fired].ship
        if ship.health != 0
          @computer_result = "Hit"
          return true
        else
          @computer_result = "Sunk"
          return true
        end
      else
        @computer_result = "Miss"
        return true
      end
    else 
      @computer_result = "Computer Invalid"
      return false
    end
  end

  def random_coordinate
    @player_board.cells.keys.sample
  end

  def fire_shots
    player_fire_shot
    computer_fire_shot
  end

  def report(result)
    if result == "Hit"
      return "That's a hit!"
    elsif result == "Miss"
      return "That's a miss!"
    elsif result == "Sunk"
      return "You sunk my BATTLESHIP!"
    else
      if result == "Player Invalid"
        return  "That coordinate has already been fired upon!\n" +
                "Try another coordinate: \n>"
      else
        computer_fire_shot
      end
    end
  end
end