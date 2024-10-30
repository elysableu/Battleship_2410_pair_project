require './spec/spec_helper'

RSpec.describe Game do
  before(:each) do
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @computer_board = Board.new
    @player_board = Board.new
    @turn_1 = Turn.new("D3", @player_board, @computer_board)
    @turn_2 = Turn.new("D2", @player_board, @computer_board)
    @turn_3 = Turn.new("D4", @player_board, @computer_board)
    @turn_4 = Turn.new("D2", @player_board, @computer_board)
    @game = Game.new 
  end
  describe "#initialize" do
    it "exists" do
      expect(@game).to be_a(Game)
    end

    it "has a winner deafault to empty" do
      expect(@game.winner).to be_empty
    end

  end

  describe "#setup" do
    # Not sure how to write these tests to pass considering randomness
    # it "can setup computer board" do
    #   computer_cruiser_placement = ["A4", "B4", "C4"]
    #   computer_submarine_placement = ["D3", "D4"]

    #   expect(@game.setup(@computer_board, 
    #                     computer_cruiser_placement, 
    #                     computer_submarine_placement)).to be true
    # end

    # it "can update computer board with setup" do
    #   computer_cruiser_placement = ["A4", "B4", "C4"]
    #   computer_submarine_placement = ["D3", "D4"]

    #   @game.setup(@computer_board, computer_cruiser_placement, computer_submarine_placement)
    #   expect(@computer_board.render(true)).to eq(setup_computer_board)
    # end

    # it "can create random valid placements for computer ships" do
    #   random_cruiser_placement_array = @game.random_placement(@cruiser)
    #   random_submarine_placement_array = @game.random_placement(@submarine)

    #   expect(@computer_board.valid_placement?(@cruiser, random_cruiser_placement_array)).to be true
    #   expect(@computer_board.valid_placement?(@submarine, random_submarine_placement_array)).to be true
    # end

    it "can transform player string input into array" do
      player_input = "B1 B2 B3"
      
      expect(@game.player_placement(player_input)).to eq(["B1", "B2", "B3"])
    end

    it "can setup player board" do
      player_cruiser_placement = ["B1", "B2", "B3"]
      player_submarine_placement = ["A1", "A2"]

      expect(@game.setup(@player_board, "user",
                        player_cruiser_placement, 
                        player_submarine_placement)).to be true
    end

    it "returns false if invalid player placement" do
      player_cruiser_placement = ["B1", "B2", "B3"]
      player_submarine_placement = ["C3", "B3"]

      expect(@game.setup(@player_board, "user",
                        player_cruiser_placement, 
                        player_submarine_placement)).to be false
    end

    it "asks player to enter a new placement if previously invalid" do
      player_cruiser_placement = ["B1", "B2", "B3"]
      player_submarine_placement = ["C3", "B3"]

      @game.setup(@player_board, "user",
                        player_cruiser_placement, 
                        player_submarine_placement)
      
      expect(@game.message).to eq("That's an invalid placement! Try again: \n> ")                  
    end

    it "can update player board when setup" do
      player_cruiser_placement = ["B1", "B2", "B3"]
      player_submarine_placement = ["A1", "A2"]
      setup_player_board =  "  1 2 3 4 \n" + 
                              "A S S . . \n" + 
                              "B S S S . \n" + 
                              "C . . . . \n" + 
                              "D . . . . \n"

      @game.setup(@player_board, "user", player_cruiser_placement, player_submarine_placement)
      expect(@player_board.render(true)).to eq(setup_player_board)
    end
  end

  
end
