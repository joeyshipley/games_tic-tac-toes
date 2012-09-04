require 'game_board'
require 'tiles'

class GameBoard3d
  include GameBoard

  def initialize
    @tiles = Tiles.new
    ("1".."27").each do |i|
      @tiles.push({ :square => i, :owner => :none })
    end
    @center_tile = "14"

    # NOTE: the implementation for winning identifiers and winning sets are rough
    # in the 3d board. Look into alternate implementation ideas.
    @tile_set_identifiers = [
      # rows: x
      ["1", "2", "3"],
      ["4", "5", "6"],
      ["7", "8", "9"],
      ["10", "11", "12"],
      ["13", "14", "15"],
      ["16", "17", "18"],
      ["19", "20", "21"],
      ["22", "23", "24"],
      ["25", "26", "27"],
      # columns: y
      ["1", "4", "7"],
      ["2", "5", "8"],
      ["3", "6", "9"],
      ["10", "13", "16"],
      ["11", "14", "17"],
      ["12", "15", "18"],
      ["19", "22", "25"],
      ["20", "23", "26"],
      ["21", "24", "27"],
      # pillars: z
      ["1", "10", "19"],
      ["2", "11", "20"],
      ["3", "12", "21"],
      ["4", "13", "22"],
      ["5", "14", "23"],
      ["6", "15", "24"],
      ["7", "16", "25"],
      ["8", "17", "26"],
      ["9", "18", "27"],
      # diagonals: x
      ["1", "5", "9"],
      ["7", "5", "3"],
      ["10", "14", "18"],
      ["16", "14", "12"],
      ["19", "23", "27"],
      ["15", "23", "21"],
      # diagonals: y
      ["1", "11", "21"],
      ["3", "11", "19"],
      ["4", "14", "24"],
      ["6", "14", "22"],
      ["7", "17", "27"],
      ["9", "17", "25"],
      # diagonals: z
      ["1", "13", "25"],
      ["7", "13", "19"],
      ["2", "14", "26"],
      ["8", "14", "20"],
      ["3", "15", "27"],
      ["9", "15", "21"],
      # diagonals: x/y/z
      ["1", "14", "27"],
      ["9", "14", "19"],
      ["7", "14", "21"],
      ["3", "14", "25"]
    ]
  end

  def get_winning_move_set
    move_set = []
    player_tile = get_player_tiles[0][:square]
    case player_tile
    # corners : top/middle
    when "1", "7", "10", "16"
      move_set = ["22", "13"]
    # corners : top/middle
    when "3", "9", "12", "18"
      move_set = ["24", "15"]
    # corners : bottom
    when "19", "25"
      move_set = ["4", "13"]
    # corners : bottom
    when "21", "27"
      move_set = ["6", "15"]
    # edges : top/middle
    when "4", "8", "13", "17"
      move_set = ["25", "16"]
    # edges : top/middle
    when "2", "6", "11", "15"
      move_set = ["21", "12"]
    # edges : bottom
    when "22", "26"
      move_set = ["7", "16"]
    # edges : bottom
    when "20", "24"
      move_set = ["3", "12"]
    # center : top
    when "5"
      move_set = ["1", "10"]
    # center : bottom
    when "23"
      move_set = ["19", "10"]
    end
    move_set
  end

  def for_display
    board = ""
    board += "                            \n"
    board += "               /      /     \n"
    board += "         #{t("1")}   /  #{t("2")}  /  #{t("3")}  \n"
    board += "             /      /       \n"
    board += "      ------ ------ -----   \n"
    board += "           /      /         \n"
    board += "      #{t("4")}  /  #{t("5")}  /  #{t("6")}      \n"
    board += "         /      /           \n"
    board += "  ------ ------ ------      \n"
    board += "       /      /             \n"
    board += "  #{t("7")}  /  #{t("8")}  /  #{t("9")}          \n"
    board += "     /      /               \n"
    board += "               /      /     \n"
    board += "          #{t("10")}  /  #{t("11")}  /  #{t("12")}  \n"
    board += "             /      /       \n"
    board += "      ------ ------ -----   \n"
    board += "           /      /         \n"
    board += "      #{t("13")}  /  #{t("14")}  /  #{t("15")}      \n"
    board += "         /      /           \n"
    board += "  ------ ------ ------      \n"
    board += "       /      /             \n"
    board += "   #{t("16")} /  #{t("17")}  /  #{t("18")}          \n"
    board += "     /      /               \n"
    board += "               /      /     \n"
    board += "          #{t("19")}  /  #{t("20")}  /  #{t("21")}  \n"
    board += "             /      /       \n"
    board += "      ------ ------ -----   \n"
    board += "           /      /         \n"
    board += "      #{t("22")}  /  #{t("23")}  /  #{t("24")}      \n"
    board += "         /      /           \n"
    board += "  ------ ------ ------      \n"
    board += "       /      /             \n"
    board += "  #{t("25")}  /  #{t("26")}  /  #{t("27")}          \n"
    board += "     /      /               \n"
    board += "                            \n"

    board
  end

  def t(square)
    tile_display_for_potential_multi_digits(square)
  end

  def tile_display_for_potential_multi_digits(square)
    # NOTE: hrm... don't like local variables?
    return  " " + tile_display(square) if tile_display(square).length == 1
    tile_display(square)
  end
end
