require './lib/ship'
require './lib/cell'


RSpec.describe Cell do
  before(:each) do
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end
  describe "#initialize" do
    it "Initializes" do
      expect(@cell).to be_a Cell
    end

    it "populates coordinate attribute" do
      expect(@cell.coordinate).to eq("B4")
    end

    it "defaults nil for ship" do
      expect(@cell.ship).to be nil
    end

    it "recognizes cell as empty? if ship is nil" do
      expect(@cell.ship).to be nil
      expect(@cell.empty?).to be true
    end
  end
end