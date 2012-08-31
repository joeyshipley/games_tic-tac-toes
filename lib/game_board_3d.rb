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

  def for_display
    t1 = tile_display_for_potential_multi_digits("1")
    t2 = tile_display_for_potential_multi_digits("2")
    t3 = tile_display_for_potential_multi_digits("3")
    t4 = tile_display_for_potential_multi_digits("4")
    t5 = tile_display_for_potential_multi_digits("5")
    t6 = tile_display_for_potential_multi_digits("6")
    t7 = tile_display_for_potential_multi_digits("7")
    t8 = tile_display_for_potential_multi_digits("8")
    t9 = tile_display_for_potential_multi_digits("9")
    t10 = tile_display_for_potential_multi_digits("10")
    t11 = tile_display_for_potential_multi_digits("11")
    t12 = tile_display_for_potential_multi_digits("12")
    t13 = tile_display_for_potential_multi_digits("13")
    t14 = tile_display_for_potential_multi_digits("14")
    t15 = tile_display_for_potential_multi_digits("15")
    t16 = tile_display_for_potential_multi_digits("16")
    t17 = tile_display_for_potential_multi_digits("17")
    t18 = tile_display_for_potential_multi_digits("18")
    t19 = tile_display_for_potential_multi_digits("19")
    t20 = tile_display_for_potential_multi_digits("20")
    t21 = tile_display_for_potential_multi_digits("21")
    t22 = tile_display_for_potential_multi_digits("22")
    t23 = tile_display_for_potential_multi_digits("23")
    t24 = tile_display_for_potential_multi_digits("24")
    t25 = tile_display_for_potential_multi_digits("25")
    t26 = tile_display_for_potential_multi_digits("26")
    t27 = tile_display_for_potential_multi_digits("27")

    board = "#{t1}"

    board = ""
    board += "                            \n"
    board += "               /      /     \n"
    board += "          #{t1}   /   #{t2}  /   #{t3}  \n"
    board += "             /      /       \n"
    board += "      ------ ------ -----   \n"
    board += "           /      /         \n"
    board += "       #{t4}  /   #{t5}  /   #{t6}      \n"
    board += "         /      /           \n"
    board += "  ------ ------ ------      \n"
    board += "       /      /             \n"
    board += "   #{t7}  /   #{t8}  /   #{t9}          \n"
    board += "     /      /               \n"
    board += "               /      /     \n"
    board += "          #{t10}  /  #{t11}  /  #{t12}  \n"
    board += "             /      /       \n"
    board += "      ------ ------ -----   \n"
    board += "           /      /         \n"
    board += "      #{t13}  /  #{t14}  /  #{t15}      \n"
    board += "         /      /           \n"
    board += "  ------ ------ ------      \n"
    board += "       /      /             \n"
    board += "   #{t16} /  #{t17}  /  #{t18}          \n"
    board += "     /      /               \n"
    board += "               /      /     \n"
    board += "          #{t19}  /  #{t20}  /  #{t21}  \n"
    board += "             /      /       \n"
    board += "      ------ ------ -----   \n"
    board += "           /      /         \n"
    board += "      #{t22}  /  #{t23}  /  #{t24}      \n"
    board += "         /      /           \n"
    board += "  ------ ------ ------      \n"
    board += "       /      /             \n"
    board += "  #{t25}  /  #{t26}  /  #{t27}          \n"
    board += "     /      /               \n"
    board += "                            \n"

    board
  end

  def tile_display_for_potential_multi_digits(square)
    display_value = tile_display(square)

    if(get_tile_owner(square) != :none && square.to_i > 9)
      display_value = " " + display_value
    end

    display_value
  end
end
