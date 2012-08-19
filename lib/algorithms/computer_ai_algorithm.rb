require 'algorithms/game_status_algorithm'

class ComputerAiAlgorithm
  def initialize(game_status_algorithm)
    @game_status = game_status_algorithm
    @depth = 99
  end

  def calculate(board)
    @highest_tile = nil
    @highest_score = nil
    #----------------------------------------------------------
    #puts ""
    #puts "move values:"
    #----------------------------------------------------------

    available_moves = board.available_tiles
    available_moves.each do |tile|
      tile_value = minimax(board, tile[:square], @depth, :computer)
      #----------------------------------------------------------
      #puts "#{tile[:square]} : #{tile_value}"
      #----------------------------------------------------------
      check_against_other_tiles(tile[:square], tile_value)
    end

    return @highest_tile
  end

  private

  def check_against_other_tiles(tile, score)
    @highest_tile = tile if @highest_tile.nil?
    @highest_score = score if @highest_score.nil?

    if score > @highest_score
      @highest_tile = tile
      @highest_score = score
    end
  end

  def minimax(board, square, depth, owner)
    is_game_over = @game_status.check_status(board) != :none
    return get_tile_score(board) if is_game_over || depth == 0

    board.apply_move(owner, square)
    available_tiles = board.available_tiles

    best_score = 99
    if owner == :computer
      available_tiles.each do |tile|
        score = minimax(board, tile[:square],  depth - 1, :player)
        best_score = best_score + score if score < best_score
      end
      board.apply_move(:none, square)
      return best_score
    else
      best_score = -best_score
      available_tiles.each do |tile|
        score = minimax(board, tile[:square],  depth - 1, :computer)
        best_score = best_score + score if score > best_score
      end
      board.apply_move(:none, square)
      return best_score
    end

  end

  def get_tile_score(board)
    winner = @game_status.check_status(board)
    return 99 if winner == :computer
    return 1 if winner == :draw
    return 0 if winner == :none
    return -1 if winner == :player
  end
end
