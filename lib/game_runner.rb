require 'game_board'

class GameRunner
  attr_accessor :board

  def initialize
    @board = GameBoard.new
  end

  def perform_turn
    output display_board
    player_choice = ask_for_player_move

    if validate_move(player_choice)
      @board.apply_move(:player, player_choice)
    end
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

  def ask_for_player_move
    output 'Please choose your move:'
    input.to_i
  end

  def validate_move(square)
    is_available = is_move_available(square)
    output "Sorry the move has already been taken." unless is_available

    is_valid = is_move_valid(square)
    output "Sorry, that was an invalid choice. Please try again." unless is_valid

    is_available && is_valid
  end

  def is_move_available(square)
    @board.is_tile_available(square)
  end

  def is_move_valid(square)
    @board.is_tile_valid
  end
end
