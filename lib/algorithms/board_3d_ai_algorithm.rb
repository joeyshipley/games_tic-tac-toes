require "algorithms/board_algorithm"

class Board3dAiAlgorithm
  include BoardAlgorithm

  attr_accessor :move_set

  def initialize(game_status_algorithm)
    @game_status = game_status_algorithm
    @move_set = []
  end

  def calculate(board)
    determine_move_set(board) if @move_set.empty?
    winning_move = determine_winning_move(board)
    return winning_move unless winning_move.nil?
    return board.center_tile if board.get_tile_owner(board.center_tile) == :none
    return determine_move_from_set(board)
  end

  private

  def determine_winning_move(board)
    board.available_tiles.each do |tile|
      board_copy = copy(board, :computer, tile[:square])
      winner = @game_status.check_status(board_copy)
      return tile[:square] if winner == :computer
    end
    nil
  end

  def determine_move_from_set(board)
    @move_set.each do |choice|
      return choice if board.is_tile_available(choice)
    end
  end

  def determine_move_set(board)
    @move_set = board.get_winning_move_set
  end
end
