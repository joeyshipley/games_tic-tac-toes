class GameStatusAlgorithm
  def check_status(board, players)
    @players = players
    winner = :none
    board.tile_set_identifiers.each do |set_squares|
      break unless winner == :none
      winner = get_winner_for_set(board.tiles, set_squares)
    end
    winner
  end

  private

  def get_winner_for_set(all_tiles, set_squares)
    set_tiles = build_set_from(all_tiles, set_squares)

    winner = :none
    @players.each do |owner|
      set_winner = determine_winner_of_set(set_tiles, owner)
      winner = set_winner unless set_winner == :none
    end
    winner
  end

  def determine_winner_of_set(set_tiles, owner)
    owned_tiles = set_tiles.select { |tile| tile[:owner] == owner }
    return owner if owned_tiles.length == set_tiles.size
    :none
  end

  def build_set_from(tiles, squares)
    set_tiles = []
    squares.each do |square|
      set_tiles.push tiles.find { |tile| tile[:square] == square }
    end
    set_tiles
  end
end
