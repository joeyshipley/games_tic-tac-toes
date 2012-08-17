require 'game_board'
require 'game_status_algorithm'

class GameRunner
  attr_accessor :board

  def initialize
    @board = GameBoard.new
    @game_status = GameStatusAlgorithm.new
    @players = [ :player, :computer ]
  end

  def start
    @winner = :none
    while @winner == :none do
      perform_turn
      check_game_status
    end
    output display_board
    output display_winner
  end

  def perform_turn
    output display_board

    player_took_action = perform_player_action
    check_game_status

    # return if game_over
    # return if player_did_not_go

    # return if test_me == true
    return unless player_took_action
    return if @winner != :none

    perform_computer_action 
  end

  def check_game_status
    @winner = @game_status.check_status(@board, @players)
  end

  def perform_player_action
    player_choice = ask_for_player_move
    if validate_move(player_choice)
      @board.apply_move(:player, player_choice)
      return true
    end
    false
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

  def display_winner
    return "The #{@winner} has won the game." if @winner == :computer || @winner == :player
    return "Game was a tie." if @winner == :draw
  end
end
