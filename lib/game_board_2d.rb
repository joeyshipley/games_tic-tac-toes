require 'game_board'
require 'tiles'

class GameBoard2d
  include GameBoard

  def initialize
    @tiles = Tiles.new
    ("1".."9").each do |i|
      @tiles.push({ :square => i, :owner => :none })
    end
    @center_tile = "5"

    @tile_set_identifiers = [
      # rows
      ["1", "2", "3"],
      ["4", "5", "6"],
      ["7", "8", "9"],
      # columns
      ["1", "4", "7"],
      ["2", "5", "8"],
      ["3", "6", "9"],
      # diagonals
      ["1", "5", "9"],
      ["7", "5", "3"]
    ]
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
end
