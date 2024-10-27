class Board

  def initialize

  end

  def cells
    cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
    }

    return cells
  end

  def valid_coordinate?(cell)
    range_nums = (1..4).to_a.to_s
    range_abc = ("A".."D").to_a

    return false if cell.length != 2
    
    if range_abc.include?(cell[0]) && range_nums.include?(cell[-1])
      return true
    else
      return false
    end
  end

  def valid_placement?(ship, coordinates_array)
    if ship_length_matches_coordinates_array?(ship, coordinates_array) == true
      if consecutive_coordinates?(ship, coordinates_array) == true
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def ship_length_matches_coordinates_array?(ship, coordinates_array)
    if ship.length == coordinates_array.count
      return true
    else 
      return false
    end
  end

  def consecutive_coordinates?(ship, coordinates_array)
    if determine_row_or_column == "row"

    end
  end

  def determine_row_or_column(coordinates_array)
    if coordinates_array.all?(/A/) || coordinates_array.all?(/B/) || coordinates_array.all?(/C/) || coordinates_array.all?(/D/)
      return "row"
    else
      return "column"
    end
  end
end