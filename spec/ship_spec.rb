require './spec/spec_helper'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe Ship do 
  before(:each) do
    @cruiser = Ship.new("Cruiser", 3)
  end

  describe "#initialize" do
    it "exists" do
      expect(@cruiser).to be_a Ship
    end

    it "has name attribute" do
      expect(@cruiser.name).to eq("Cruiser")
    end

    it "has a length attribute" do 
      expect(@cruiser.length).to eq(3)
    end

    it "has health equal to length" do
      expect(@cruiser.health).to eq(3)
    end
  end

  describe "#sunk?/hit" do
    it "defaults sunk? to false" do
      expect(@cruiser.sunk?).to be false
    end

    it "can lose health when hit" do
      expect(@cruiser.health).to eq(3)

      @cruiser.hit
      expect(@cruiser.health).to eq(2)
    end

    it "can only be sunk when health is 0" do
      expect(@cruiser.health).to eq(3)

      @cruiser.hit
      expect(@cruiser.health).to eq(2)
      expect(@cruiser.sunk?).to be false

      @cruiser.hit
      expect(@cruiser.health).to eq(1)
      expect(@cruiser.sunk?).to be false

      @cruiser.hit
      expect(@cruiser.health).to eq(0)
      expect(@cruiser.sunk?).to be true
      
    end
  end
end