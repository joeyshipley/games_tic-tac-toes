require 'algorithms/game_status_algorithm'

class ComputerAiAlgorithm
  def initialize(game_status_algorithm)
    @game_status = game_status_algorithm
    @max_depth = 9
  end

  def calculate(board)
    puts ""
    puts "move values:"

    available_moves = board.available_tiles
    available_moves.each do |tile|
      current_depth = 1
      tile_value = tile_value_from(board, tile[:square], current_depth, :computer)
      check_tile_against_highest_tile_found(tile, tile_value)
      puts "#{tile[:square]} : #{tile_value}"
    end

    return @highest_tile
  end

  private

  def analysis_of_tile_value(board, square, owner)
    opponent = get_opponent_of(owner)
    has_won = @game_status.check_status(board)
    value = 0
    value = 10000 if has_won == owner
    value = 1000 if has_won == :draw
    value = -10000 if has_won == opponent
    return value * get_nega_mod_multipler_from(owner)
  end

  def tile_value_from(board, square, depth, owner)
    future_board = setup_future_board_from(board, square, owner)
    is_game_over = @game_status.check_status(future_board) != :none
    if is_game_over || depth > @max_depth
      return analysis_of_tile_value(future_board, square, owner)
    end

    return process_value_from(future_board, depth, owner)
  end

  def setup_future_board_from(board, square, owner)
    future_board = Marshal::load(Marshal.dump(board))
    future_board.apply_move(owner, square)
    return future_board
  end

  def process_value_from(board, depth, owner)
    nega_mod = get_nega_mod_multipler_from(owner)
    current_value = 1 * nega_mod
    opponent = get_opponent_of(owner)

    available_tiles = board.available_tiles
    available_tiles.each do |tile|
      deep_value = tile_value_from(board, tile[:square], depth + 1, opponent)
      current_value = deep_value if (deep_value * nega_mod) < (current_value * nega_mod)
    end

    return current_value
  end

  def get_nega_mod_multipler_from(owner)
    return owner == :player ? -1 : 1
  end

  def get_opponent_of(owner)
    return owner == :computer ? :player : :computer
  end

  def check_tile_against_highest_tile_found(tile, tile_value)
    if @highest_tile_value.nil? || tile_value > @highest_tile_value
      @highest_tile_value = tile_value
      @highest_tile = tile[:square]
    end
  end
end
