class Game 
  attr_reader :winner, :message

  def initialize()
    @winner = ""
    @message = ""
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def setup(board, player = "", cruiser_placement = [], submarine_placement = [])
    if player == "user"
      if board.valid_placement?(@cruiser, cruiser_placement)
        board.place(@cruiser, cruiser_placement)
        if board.valid_placement?(@submarine, submarine_placement)
          board.place(@submarine, submarine_placement)
          board.render(true)
          return true
        else
          @message = "That's an invalid placement! Try again: \n> "
          return false
        end
      else
        @message = "That's an invalid placement! Try again: \n> "
        return false
      end
    else
      random_cruiser_placement = random_placement(@cruiser)
      random_submarine_placement = random_placement(@submarine)
      
      until validate_random(board, random_cruiser_placement, random_submarine_placement) == true
        random_cruiser_placement = random_placement(@cruiser)
        random_submarine_placement = random_placement(@submarine)
      end

      if board.valid_placement?(@cruiser, random_cruiser_placement)
        board.place(@cruiser, random_cruiser_placement)
        if board.valid_placement?(@submarine, random_submarine_placement)
          board.place(@submarine, random_submarine_placement)
          board.render(true)
          return true
        else
          return false
        end
      else
        return false
      end
    end
  end

  def random_placement(ship)
    placement = []
    range_nums = (1..4).to_a.map(&:to_s)
    range_abc = ("A".."D").to_a
    ship_size = (1..ship.length).to_a
    
    ship_size.each do
      coordinate = range_abc.sample + range_nums.sample
      if !placement.include?(coordinate)
        placement << coordinate
      end
    end
    return placement
  end

  def validate_random(board, cruiser_placement, submarine_placement)
    if board.valid_placement?(@cruiser, cruiser_placement)
      if board.valid_placement?(@submarine, submarine_placement)
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def player_placement(input)
    placement = input.split(" ")
    return placement
  end

  
end
