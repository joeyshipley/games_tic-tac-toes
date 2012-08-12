class GameBoard
  attr_accessor :moves

  def initialize
    @moves = []
    (1..9).each do |i|
      @moves.push({ :square => i, :owner => :none })
    end
  end

  def get_move_owner(square)
    move = @moves.find { |move| move[:square] == square }
    move[:owner]
  end

  def apply_move(owner, square)
    move = @moves.find { |move| move[:square] == square }
    move[:owner] = owner
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
