require 'game_board'

class GameRunner
  attr_accessor :ui
  attr_accessor :board

  def initialize
    @board = GameBoard.new
  end

  def perform_turn
    @ui = display_board
    @ui += 'Please choose your move:'
    output @ui
    input
  end

  def output(message)
    puts message
  end

  def input
    gets.chomp
  end

  def display_board
    @board.for_display
  end
end
