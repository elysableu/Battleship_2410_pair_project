class Cell
  attr_reader :coordinate, :ship
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired = false
  end

  def empty?
    if @ship == nil
      return true
    else
      return false
    end
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired
  end

  def fire_upon
    @fired = true
    if ship != nil
      @ship.hit
    end
  end

  def render(s = false)
    if fired_upon? == true && empty? == false && @ship.sunk? == true
      return "X"
    elsif fired_upon? == true && empty? == false && @ship.sunk? == false
      return "H"
    elsif fired_upon? == true && empty? == true
      return "M"
    elsif s == true && empty? == false
      return "S"
    else
      return "."
    end
  end
end