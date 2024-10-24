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
  end
end