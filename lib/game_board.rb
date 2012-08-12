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
    board = ""
    board += "                   \n"
    board += "      |     |      \n"
    board += "   #{tile_display(1)}  |  #{tile_display(2)}  |  #{tile_display(3)}   \n"
    board += "      |     |      \n"
    board += " ----- ----- ----- \n"
    board += "      |     |      \n"
    board += "   #{tile_display(4)}  |  #{tile_display(5)}  |  #{tile_display(6)}   \n"
    board += "      |     |      \n"
    board += " ----- ----- ----- \n"
    board += "      |     |      \n"
    board += "   #{tile_display(7)}  |  #{tile_display(8)}  |  #{tile_display(9)}   \n"
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
