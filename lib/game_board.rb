require 'board_move'

class GameBoard
  attr_accessor :moves

  def initialize
    @moves = [
      BoardMove.new( 1, :none ),
      BoardMove.new( 2, :none ),
      BoardMove.new( 3, :none ),
      BoardMove.new( 4, :none ),
      BoardMove.new( 5, :none ),
      BoardMove.new( 6, :none ),
      BoardMove.new( 7, :none ),
      BoardMove.new( 8, :none ),
      BoardMove.new( 9, :none )
    ]
  end

  def get_move_owner(square)
    move = @moves.find { |move| move.square == square }
    move.owner
  end

  def apply_move(owner, square)
    move = @moves.find { |move| move.square == square }
    move.owner = owner
  end

  def for_display
    board = ""
    board += "                   \n"
    board += "      |     |      \n"
    board += "   1  |  2  |  3   \n"
    board += "      |     |      \n"
    board += " ----- ----- ----- \n"
    board += "      |     |      \n"
    board += "   4  |  5  |  6   \n"
    board += "      |     |      \n"
    board += " ----- ----- ----- \n"
    board += "      |     |      \n"
    board += "   7  |  8  |  9   \n"
    board += "      |     |      \n"
    board += "                   \n"

    return board
  end
end
