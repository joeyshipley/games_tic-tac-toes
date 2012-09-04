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
    player_tile = board.get_player_tiles[0][:square]
    case player_tile
    # corners : top/middle
    when "1", "7", "10", "16"
      @move_set = ["22", "13"]
    # corners : bottom
    when "19", "25"
      @move_set = ["4", "13"]
    # corners : top/middle
    when "3", "9", "12", "18"
      @move_set = ["24", "15"]
    # corners : bottom
    when "21", "27"
      @move_set = ["6", "15"]
    # edges : top/middle
    when "4", "8", "13", "17"
      @move_set = ["25", "16"]
    # edges : bottom
    when "22", "26"
      @move_set = ["7", "16"]
    # edges : top/middle
    when "2", "6", "11", "15"
      @move_set = ["21", "12"]
    # edges : bottom
    when "20", "24"
      @move_set = ["3", "12"]
    # center : top
    when "5"
      @move_set = ["1", "10"]
    # center : bottom
    when "23"
      @move_set = ["19", "10"]
    end
  end
end
