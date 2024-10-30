class Turn
  attr_reader :player_fired, :player_board, :computer_board
  def initialize(player_fired, player_board, computer_board)
    @player_fired = player_fired
    @player_board = player_board
    @computer_board = computer_board
  end

 
end