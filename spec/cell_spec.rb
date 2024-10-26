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

    describe "#place_ship" do
      it "can place ship" do
        expect(@cell.empty?).to be true

        @cell.place_ship(@cruiser)
        expect(@cell.ship).to eq(@cruiser)
        expect(@cell.empty?).to be false
      end
    end

    describe "#fire_upon" do
      it "cell defaults false for fired_upon?" do
        @cell.place_ship(@cruiser)
        expect(@cell.fired_upon?).to be false
      end

      it "fire_upon reduces ships health" do
        @cell.place_ship(@cruiser)
        expect(@cell.fired_upon?).to be false
        @cell.fire_upon
        expect(@cell.ship.health).to eq(2)
        expect(@cell.fired_upon?).to be true
      end
    end
    
    describe "#render" do
      before(:each) do
        @cell_1 = @cell
        @cell_2 = Cell.new("C3")
      end

      it "renders '.' be default" do
        expect(@cell_1.render).to eq(".")
      end

      it "renders 'M' if fired upon with no ship" do
        expect(@cell_1.render).to eq(".")

        @cell_1.fire_upon

        expect(@cell_1.render).to eq("M")
      end

      it "renders '.' even when not empty" do
        @cell_2.place_ship(@cruiser)

        expect(@cell_2.ship).to eq(@cruiser)
        expect(@cell_2.render).to eq(".")
      end

      it "renders 'S' when optional argument is true" do

      end

      it "renders 'H' when cell with ship is fired_upon" do
        @cell_2.place_ship(@cruiser)
        expect(@cell_2.render).to eq(".")

        @cell_2.fire_upon
        expect(@cell_2.render).to eq("H")
      end

      it "renders 'X' when ship is sunk" do
        @cell_2.place_ship(@cruiser)

        @cell_2.fire_upon
        expect(@cell_2.render).to eq("H")
        expect(@cruiser.sunk?).to be false

        # Ship is hit in other two cells
        @cruiser.hit 
        @cruiser.hit
        expect(@cruiser.sunk?).to be true
        expect(@cell_2.render).to eq("X")
      end
    end
  end
end