require 'tiles'

class GameStatusAlgorithm
  def check_status(board, players)
    @players = players
    @winner = :none
    board.tile_set_identifiers.each do |set_squares|
      break unless @winner == :none
      determine_winner_for_set(board.tiles, set_squares)
    end
    return :draw if is_game_a_draw(board)
    @winner
  end

  private

  def determine_winner_for_set(all_tiles, set_squares)
    set_tiles = build_set_from(all_tiles, set_squares)
    @players.each do |owner|
      owned_tiles = set_tiles.owned_tiles(owner)
      @winner = owner if owned_tiles.length == set_tiles.size
    end
  end

  def build_set_from(tiles, squares)
    set_tiles = Tiles.new
    squares.each do |square|
      set_tiles.push tiles.find { |tile| tile[:square] == square }
    end
    set_tiles
  end

  def is_game_a_draw(board)
    return @winner == :none && !board.has_available_tiles?
  end
end
