require 'algorithms/game_status_algorithm'

class ComputerAiAlgorithm
  Infinity = 1.0/0

  def initialize(game_status_algorithm)
    @game_status = game_status_algorithm
  end

  def calculate(board)
    @highest_tile = nil
    @highest_score = nil
    #----------------------------------------------------------
    puts ""
    puts "move values:"
    #----------------------------------------------------------

    available_moves = board.available_tiles
    available_moves.each do |tile|
      tile_value = max(board, tile[:square], 9)
      #----------------------------------------------------------
      puts "#{tile[:square]} : #{tile_value}"
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

  def max(board, square, depth)
    board.apply_move(:computer, square)
    winner = @game_status.check_status(board)
    if winner != :none || depth <= 0
      board.apply_move(:none, square)
      return -2 * depth if winner == :player
      return 2 * depth if winner == :computer
      return 1 * depth if winner == :draw
      return 0 if depth <= 0
    end

    best_score = Infinity
    board.available_tiles.each do |tile|
      score = min(board, tile[:square], depth - 1)
      best_score = score if score < best_score
    end

    board.apply_move(:none, square)
    return best_score
  end

  def min(board, square, depth)
    board.apply_move(:player, square)
    winner = @game_status.check_status(board)
    if winner != :none || depth <= 0
      board.apply_move(:none, square)
      return 2 * depth if winner == :player
      return -2 * depth if winner == :computer
      return -2 * depth if winner == :draw
      return 0 if depth <= 0
    end

    best_score = -Infinity
    board.available_tiles.each do |tile|
      score = max(board, tile[:square], depth - 1)
      best_score = score if score > best_score
    end

    board.apply_move(:none, square)
    return best_score
  end

end
