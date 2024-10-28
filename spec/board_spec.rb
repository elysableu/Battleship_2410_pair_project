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

  describe "#valid_coordinate" do
    it "returns true if on board" do
      expect(@board.valid_coordinate?("A1")).to be true
      expect(@board.valid_coordinate?("D4")).to be true
    end

    it "returns false if not on board" do
      expect(@board.valid_coordinate?("A5")).to be false
      expect(@board.valid_coordinate?("E1")).to be false
      expect(@board.valid_coordinate?("A22")).to be false
    end
  end

  describe "#valid_placement" do
    it "has array of coordinates equal to ship length" do
      expect(@board.valid_placement?(@cruiser, ["A1", "A2"])).to be false
      expect(@board.valid_placement?(@submarine, ["A2", "A3", "A4"])).to be false
    end

    it "has consecutive coordinates" do
      expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to be false
      expect(@board.valid_placement?(@submarine, ["A1", "C1"])).to be false
      expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"])).to be false
      expect(@board.valid_placement?(@submarine, ["C1", "B1"])).to be false
    end

    it "can't have diagonal coordinates" do
      expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"])).to be false
      expect(@board.valid_placement?(@submarine, ["C2", "D3"])).to be false
    end

    it "can have valid placement" do 
      expect(@board.valid_placement?(@submarine, ["A1", "A2"])).to be true
      expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to be true
    end
  end

  describe "#place_ship" do
    xit "can place ship" do
      @board.place(@cruiser, ["A1", "A2", "A3"])
      cell_1 = @board.cells["A1"]
      cell_2 = @board.cells["A2"]
      cell_3 = @board.cells["A3"]

      expect(cell_1.ship).to be_a Ship
      expect(cell_2.ship).to be_a Ship
      expect(cell_3.ship).to be_a Ship
    end

    xit "has same ship object is each coordinate" do
      expect(cell_3.ship == cell_2.ship).to be true
    end
  end

  describe "#overlapping_ships" do
    xit "can return false if ship placements overlap" do
      @board.place(@cruiser, ["A1", "A2", "A3"])

      expect(board.valid_placement?(@submarine, ["A1", "B1"])).to be false
    end
  end

  describe "#render_board" do
    before(:each) do
      @board.place(@cruiser, ["A1", "A2", "A3"])
      @board.place(@submarine, ["C1", "D1"])
      
      @rendered_board = " 1 2 3 4 \n" + 
                        "A . . . . \n" + 
                        "B . . . . \n" + 
                        "C . . . . \n" + 
                        "D . . . . \n"
      @true_rendered_board = " 1 2 3 4 \n" + 
                            "A S S S . \n" + 
                            "B . . . . \n" + 
                            "C . . . . \n" + 
                            "D . . . . \n"
      @hit_rendered = " 1 2 3 4 \n" + 
                      "A H . . . \n" + 
                      "B . . . . \n" + 
                      "C . . . . \n" + 
                      "D . . . . \n"
      @true_hit_rendered = " 1 2 3 4 \n" + 
                            "A H S S . \n" + 
                            "B . . . . \n" + 
                            "C . . . . \n" + 
                            "D . . . . \n"
      @miss_rendered = " 1 2 3 4 \n" + 
                      "A . . . . \n" + 
                      "B . . . M \n" + 
                      "C . . . . \n" + 
                      "D . . . . \n"
      @true_miss_rendered = " 1 2 3 4 \n" + 
                            "A S S S . \n" + 
                            "B . . . M \n" + 
                            "C . . . . \n" + 
                            "D . . . . \n"
      @sunken_ship_rendered = " 1 2 3 4 \n" + 
                             "A . . . . \n" + 
                             "B . . . . \n" + 
                             "C X . . . \n" + 
                             "D X . . . \n"
      @true_sunken_ship_rendered = " 1 2 3 4 \n" + 
                                  "A S S S . \n" + 
                                  "B . . . . \n" + 
                                  "C X . . . \n" + 
                                  "D X . . . \n"
      @full_rendered_game = " 1 2 3 4 \n" + 
                            "A S S S . \n" + 
                            "B . . . . \n" + 
                            "C . . . . \n" + 
                            "D . . . . \n"
    end
    
    xit "can render default board" do
      expect(@board.render).to eq(@rendered_board)
    end

    xit "can render placed ship when render is true" do
      expect(@board.render).to eq(@rendered_board)
      expect(@board.render(true)).to eq(@true_rendered_board)
    end

    xit "can render hits on ships" do
      expect(@board.render).to eq(@rendered_board)
      expect(@board.render(true)).to eq(@true_rendered_board)

      @board.cells["A1"].fire_upon
      expect(@board.render).to eq(@hit_rendered)
      expect(@board.render(true)).to eq(@true_hit_rendered)
    end

    xit "can render misses" do 
      expect(@board.render).to eq(@rendered_board)
      expect(@board.render(true)).to eq(@true_rendered_board)

      @board.cells["B4"].fire_upon
      expect(@board.render).to eq(@miss_rendered)
      expect(@board.render(true)).to eq(@true_miss_rendered)
    end

    xit "can render sunken ships" do 
      expect(@board.render).to eq(@rendered_board)
      expect(@board.render(true)).to eq(@true_rendered_board)

      @board.cells["C1"].fire_upon
      @board.cells["D1"].fire_upon
      expect(@board.render).to eq(@sunken_ship_rendered)
      expect(@board.render(true)).to eq(@true_sunken_ship_rendered)
    end

    xit "can render midgame" do
      expect(@board.render).to eq(@rendered_board)
      expect(@board.render(true)).to eq(@true_rendered_board)
    end
  end
end