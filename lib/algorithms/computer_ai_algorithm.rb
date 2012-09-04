require "algorithms/board_algorithm"

class ComputerAiAlgorithm
  include BoardAlgorithm

  INFINITY = Float::INFINITY
  MAX_DEPTH = 9

  def initialize(game_status_algorithm)
    @game_status = game_status_algorithm
  end

  def calculate(board)
    @highest_tile = ""
    @highest_score = -INFINITY

    available_tiles = board.available_tiles
    available_tiles.each do |tile|
      tile_value = negamax(board, tile[:square], MAX_DEPTH, :computer, 1)
      check_result_against_highest(tile[:square], tile_value)
    end

    return @highest_tile
  end

  private

  def check_result_against_highest(square, score)
    if score > @highest_score
      @highest_tile = square
      @highest_score = score
    end
  end

  def score_tile(board, depth, winner)
    return 1 * depth if winner == :computer
    return -1 * depth if winner == :player
    return 0
  end

  def opponent(current)
    current == :player ? :computer : :player
  end

  def negamax(board, square, depth, owner, negamod)
    board_copy = copy(board, owner, square)
    winner = @game_status.check_status(board_copy)
    return score_tile(board_copy, depth, winner) if winner != :none

    best_score = INFINITY * negamod
    board_copy.available_tiles.each do |tile|
      score = negamax(board_copy, tile[:square], depth - 1, opponent(owner), -negamod)
      best_score = score if score * negamod < best_score * negamod
    end

    return best_score
  end
end
