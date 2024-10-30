require './spec/spec_helper'

RSpec.describe Turn do
  before(:each) do
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @computer_board = Board.new
    @player_board = Board.new
    @turn_1 = Turn.new("D3", @player_board, @computer_board)
    @turn_2 = Turn.new("D2", @player_board, @computer_board)
    @turn_3 = Turn.new("D4", @player_board, @computer_board)
    @turn_4 = Turn.new("D2", @player_board, @computer_board)
  end
  describe "#initialize" do
   

    it "exists" do
      expect(@turn_1).to be_a(Turn)
    end

    it "has readable attributes" do
      expect(@turn_1.player_fired).to eq("D3")
      expect(@turn_1.player_board).to eq(@player_board)
      expect(@turn_1.computer_board).to eq(@computer_board)
    end

    it "can have different turns" do
      expect(@turn_2.player_fired).to eq("D2")
    end
    
    it "can display default board" do
      expect(@turn_1.display).to eq("==========COMPUTER BOARD==========\n" +
                                    @computer_board.render + 
                                    "\n===========PLAYER BOARD===========\n" +
                                    @player_board.render(true))
    end

    it "can display starting board" do 
      @player_board.place(@cruiser, ["B1", "B2", "B3"])
      @player_board.place(@submarine, ["A1", "A2"])
      @computer_board.place(@cruiser, ["A4", "B4", "C4"])
      @computer_board.place(@submarine, ["D3", "D4"])

      expect(@turn_1.display).to eq("==========COMPUTER BOARD==========\n" +
                                    @computer_board.render + 
                                    "\n===========PLAYER BOARD===========\n" +
                                    @player_board.render(true))
    end
  end

  describe "#fire_shot" do
    it "can have player fire a shot" do
      expect(@turn_1.player_fire_shot).to be true
    end

    it "can't fire upon coordinate already fired_upon" do
      @turn_2.player_fire_shot
      @turn_4.player_fire_shot

      expect(@turn_4.player_fire_shot).to be false
    end

    it "can have computer fire a shot" do
      expect(@turn_1.computer_fire_shot).to be true
    end
  end

  describe "#report" do
    before(:each) do
      @player_board.place(@cruiser, ["B1", "B2", "B3"])
      @player_board.place(@submarine, ["A1", "A2"])
      @computer_board.place(@cruiser, ["A4", "B4", "C4"])
      @computer_board.place(@submarine, ["D3", "D4"])
    end

    it "can report a hit" do
      @turn_1.fire_shots

      player_result = @turn_1.player_result
      expect(@turn_1.display).to eq("==========COMPUTER BOARD==========\n" +
                                    @computer_board.render + 
                                    "\n===========PLAYER BOARD===========\n" +
                                    @player_board.render(true))
      
      expect(@turn_1.report(player_result)).to eq("That's a hit!")
    end

    it "can report a miss" do
      @turn_2.fire_shots

      player_result = @turn_2.player_result
      expect(@turn_2.display).to eq("==========COMPUTER BOARD==========\n" +
                                    @computer_board.render + 
                                    "\n===========PLAYER BOARD===========\n" +
                                    @player_board.render(true))
      
      expect(@turn_2.report(player_result)).to eq("That's a miss!")
    end

    it "can report a ship sunk" do
      @turn_1.fire_shots
      @turn_3.fire_shots

      player_result = @turn_3.player_result
      expect(@turn_3.display).to eq("==========COMPUTER BOARD==========\n" +
                                    @computer_board.render + 
                                    "\n===========PLAYER BOARD===========\n" +
                                    @player_board.render(true))
      
      expect(@turn_3.report(player_result)).to eq("You sunk my BATTLESHIP!")
    end

    it "can report if coordinate has already been fired upon" do
      @turn_2.fire_shots
      @turn_4.fire_shots

      player_result = @turn_4.player_result
      expect(@turn_4.display).to eq("==========COMPUTER BOARD==========\n" +
                                    @computer_board.render + 
                                    "\n===========PLAYER BOARD===========\n" +
                                    @player_board.render(true))
    
      expect(@turn_4.report(player_result)).to eq("That coordinate has already been fired upon!\n" +
                                  "Try another coordinate: \n>")
    end
  end
end