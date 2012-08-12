class GameBoard
  attr_accessor :tiles

  def initialize
    @tiles = []
    (1..9).each do |i|
      @tiles.push({ :square => i, :owner => :none })
    end
  end

  def get_tile_owner(square)
    tile = @tiles.find { |tile| tile[:square] == square }
    tile[:owner]
  end

  def apply_move(owner, square)
    tile = @tiles.find { |tile| tile[:square] == square }
    tile[:owner] = owner
  end

  def for_display
    square1 = get_display_value_for_tile_owner(1)
    square2 = get_display_value_for_tile_owner(2)
    square3 = get_display_value_for_tile_owner(3)
    square4 = get_display_value_for_tile_owner(4)
    square5 = get_display_value_for_tile_owner(5)
    square6 = get_display_value_for_tile_owner(6)
    square7 = get_display_value_for_tile_owner(7)
    square8 = get_display_value_for_tile_owner(8)
    square9 = get_display_value_for_tile_owner(9)

    board = ""
    board += "                   \n"
    board += "      |     |      \n"
    board += "   #{square1}  |  #{square2}  |  #{square3}   \n"
    board += "      |     |      \n"
    board += " ----- ----- ----- \n"
    board += "      |     |      \n"
    board += "   #{square4}  |  #{square5}  |  #{square6}   \n"
    board += "      |     |      \n"
    board += " ----- ----- ----- \n"
    board += "      |     |      \n"
    board += "   #{square7}  |  #{square8}  |  #{square9}   \n"
    board += "      |     |      \n"
    board += "                   \n"

    return board
  end

  def get_display_value_for_tile_owner(square)
    tile = @tiles.find { |tile| tile[:square] == square }
    return "X" if tile[:owner] == :player
    return "O" if tile[:owner] == :computer
    return square if tile[:owner] == :none
  end
end
