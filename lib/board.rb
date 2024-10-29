class Board
  attr_reader :cells

  def initialize
    @cells = {
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
  end

  def valid_coordinate?(coordinate)
    range_nums = (1..4).to_a.map(&:to_s)
    range_abc = ("A".."D").to_a

    return false if coordinate.length != 2
    
    if range_abc.include?(coordinate[0]) && range_nums.include?(coordinate[-1])
      return true
    else
      return false
    end
  end

  def valid_placement?(ship, coordinates_array)
    return false unless ship.length == coordinates_array.count
    return false unless coordinates_array.all? { |coordinate| cells[coordinate].empty?}
    consecutive_coordinates?(ship, coordinates_array) == true
  end

  def consecutive_coordinates?(ship, coordinates_array)
    if determine_row_or_column(coordinates_array) == "row"
      possible_placement = []
      (1..4).each_cons(ship.length) do |set|
        possible_placement << set
      end  
      row_array = coordinates_array.map { |coordinate| coordinate[-1].to_i }
      return true if possible_placement.include?(row_array)
    elsif determine_row_or_column(coordinates_array) == "column"
      possible_placement = []
      (65..68).each_cons(ship.length) do |set|
        possible_placement << set
      end  
      column_array = coordinates_array.map { |coordinate| coordinate[0].ord }
      return true if possible_placement.include?(column_array)
    else
      return false # returns false if diagonal
    end
  end

  def determine_row_or_column(coordinates_array)
    if coordinates_array.all?(/A/) || coordinates_array.all?(/B/) || coordinates_array.all?(/C/) || coordinates_array.all?(/D/)
      return "row"
    elsif coordinates_array.all?(/1/) || coordinates_array.all?(/2/) || coordinates_array.all?(/3/) || coordinates_array.all?(/4/)
      return "column"
    else
      return "diagonal"
    end
  end
end