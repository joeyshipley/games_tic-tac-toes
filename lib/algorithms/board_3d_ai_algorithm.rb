class Board3dAiAlgorithm
  attr_accessor :move_set

  def initialize(game_status_algorithm)
    @game_status = game_status_algorithm
    @move_set = []
  end

  def calculate(board)
    @winning_tile = "0"

    available_tiles = board.available_tiles
    available_tiles.each do |tile|
      board.apply_move(:computer, tile[:square])
      winner = @game_status.check_status(board)
      @winning_tile = tile[:square] if winner == :computer
      board.apply_move(:none, tile[:square])
    end

    return @winning_tile unless @winning_tile.eql? "0"
    return board.center_tile if board.get_tile_owner(board.center_tile) == :none

    determine_move_set(board)
    @move_set.each do |choice|
      return choice if board.is_tile_available(choice)
    end

    return @move_set[0]
  end

  private

  def determine_move_set(board)
    return unless @move_set.length == 0
    player_tile = board.tiles.find { |tile| tile[:owner] == :player }[:square]
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
