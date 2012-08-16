class GameBoard
  attr_accessor :tiles
  attr_reader :tile_set_identifiers

  def initialize
    @tiles = []
    ("1".."9").each do |i|
      @tiles.push({ :square => i, :owner => :none })
    end

    # Refactor needed to make this readable. This is a list of the winning
    # combos: rows, columns and diagonals for a 3x3 board...
    @tile_set_identifiers = [
      ["1", "2", "3"],
      ["4", "5", "6"],
      ["7", "8", "9"],
      ["1", "4", "7"],
      ["2", "5", "8"],
      ["3", "6", "9"],
      ["1", "5", "9"],
      ["7", "5", "3"]
    ]
  end

  def get_tile_owner(square)
    tile = @tiles.find { |tile| tile[:square] == square }
    tile[:owner]
  end

  def is_tile_available(square)
    tile = @tiles.find { |tile| tile[:square] == square }
    tile[:owner] == :none
  end

  def is_tile_valid(square)
    valid_tiles = @tiles.select { |tile| tile[:square] == square }
    valid_tiles.length > 0
  end

  def apply_move(owner, square)
    tile = @tiles.find { |tile| tile[:square] == square }
    tile[:owner] = owner
  end

  def for_display
    board = ""
    board += "                   \n"
    board += "      |     |      \n"
    board += "   #{tile_display("1")}  |  #{tile_display("2")}  |  #{tile_display("3")}   \n"
    board += "      |     |      \n"
    board += " ----- ----- ----- \n"
    board += "      |     |      \n"
    board += "   #{tile_display("4")}  |  #{tile_display("5")}  |  #{tile_display("6")}   \n"
    board += "      |     |      \n"
    board += " ----- ----- ----- \n"
    board += "      |     |      \n"
    board += "   #{tile_display("7")}  |  #{tile_display("8")}  |  #{tile_display("9")}   \n"
    board += "      |     |      \n"
    board += "                   \n"

    return board
  end

  def tile_display(square)
    tile = @tiles.find { |tile| tile[:square] == square }
    return "X" if tile[:owner] == :player
    return "O" if tile[:owner] == :computer
    return square if tile[:owner] == :none
  end
end
