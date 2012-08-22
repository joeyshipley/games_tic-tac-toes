require 'algorithms/game_status_algorithm'

class ComputerAiAlgorithm
  Infinity = 1.0/0
  MaxDepth = 9
  WeightMod = 10

  def initialize(game_status_algorithm)
    @game_status = game_status_algorithm
  end

  def calculate(board)
    @highest_tile = nil
    @highest_score = nil
    #----------------------------------------------------------
    #puts ""
    #puts "move values:"
    #----------------------------------------------------------

    available_tiles = board.available_tiles
    available_tiles.each do |tile|
      tile_value = max(board, tile[:square], MaxDepth)
      #----------------------------------------------------------
      #puts "#{tile[:square]} : #{tile_value}"
      #----------------------------------------------------------
      check_result_against_highest(tile[:square], tile_value)
    end

    return @highest_tile
  end

  private

  def check_result_against_highest(square, score)
    if @highest_tile.nil? || @highest_score.nil?
      @highest_tile = square
      @highest_score = score
    end

    if score > @highest_score
      @highest_score = score
      @highest_tile = square
    end
  end

  def score_tile(board, depth, winner)
    weight = depth * WeightMod
    return 1 * weight if winner == :computer
    return -1 * weight if winner == :player
    return 0
  end

  def copy(board, owner, square)
    board_copy = Marshal::load(Marshal.dump(board))
    board_copy.apply_move(owner, square)
    board_copy
  end

  def max(board, square, depth)
    board_copy = copy(board, :computer, square)
    winner = @game_status.check_status(board_copy)
    return score_tile(board_copy, depth, winner) if winner != :none

    best_score = Infinity
    board_copy.available_tiles.each do |tile|
      score = min(board_copy, tile[:square], depth - 1)
      best_score = score if score < best_score
    end

    return best_score
  end

  def min(board, square, depth)
    board_copy = copy(board, :player, square)
    winner = @game_status.check_status(board_copy)
    return score_tile(board_copy, depth, winner) if winner != :none

    best_score = -Infinity
    board_copy.available_tiles.each do |tile|
      score = max(board_copy, tile[:square], depth - 1)
      best_score = score if score > best_score
    end

    return best_score
  end
end
