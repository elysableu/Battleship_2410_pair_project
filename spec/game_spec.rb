require './spec/spec_helper'

RSpec.describe Game do
  describe "#initialize" do
    before(:each) do
      # player_board = Board.new(true)
      # computer_board = Board.new
      # turn = Turn.new
      game = Game.new 
    end

    it "exists" do
      expect(game).to be_a(Game)
    end

  end

  describe "#setup" do
    xit "can setup computer board" do
      
    end

    xit "can setup player board" do

    end
  end
end