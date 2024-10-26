require './spec/spec_helper'

RSpec.describe Board do
  before(:each) do
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  describe "#initialize" do
    it "Initializes" do
      expect(@board).to be_a Board
    end

    it "contains hash of cells" do
      # Is hash data type
      expect(@board.cells.is_a?(Hash)).to be true
      # Has 16 key/value pairs
      expect(@board.cells.count).to eq(16)
      # Keys point to Cell objects (values)
      expect(@board.cells.values).to all(be_a Cell)
    end
  end

 
end