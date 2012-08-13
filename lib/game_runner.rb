require 'game_board'

class GameRunner
  attr_accessor :board

  def initialize
    @board = GameBoard.new
  end

  def start
    turns_performed = 0
    while turns_performed < 2 do
      perform_turn
      turns_performed += 1
    end
  end

  def perform_turn
    output display_board
    perform_player_action
    perform_computer_action
  end

  def perform_player_action
    player_choice = ask_for_player_move
    if validate_move(player_choice)
      @board.apply_move(:player, player_choice)
    end
  end

  def perform_computer_action
    available_moves = @board.tiles.select { |tile| tile[:owner] == :none }
    @board.apply_move(:computer, available_moves[0][:square])
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
    input
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
    @board.is_tile_valid(square)
  end
end
