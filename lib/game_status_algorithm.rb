class GameStatusAlgorithm
  def initialize
    # two reasons to change:
    # - what determines a win set
    # - who the players are

    # business rules represented in unreadable code. Need a better way of
    # building this.
    @win_sets = [
      ["1", "2", "3"],
      ["4", "5", "6"],
      ["7", "8", "9"],
      ["1", "4", "7"],
      ["2", "5", "8"],
      ["3", "6", "9"],
      ["1", "5", "9"],
      ["7", "5", "3"]
    ]

    # this was created in the refactor, it now needs a better place to live.
    @players = [
      :player,
      :computer
    ]
  end

  def check_status(board)
    winner = :none
    @win_sets.each do |set|
      winner = get_winner_for_set(board, set) if winner == :none
    end
    winner
  end

  private

  def get_winner_for_set(board, squares)
    set_tiles = build_set_from(board.tiles, squares)

    winner = :none
    @players.each do |owner|
      checked_winner = check_for_winner(owner, set_tiles)
      winner = checked_winner unless checked_winner == :none
    end
    winner
  end

  def check_for_winner(owner, set_tiles)
    tiles = set_tiles.select { |tile| tile[:owner] == owner }
    if tiles.length == set_tiles.size
      return owner
    end
    :none
  end

  def build_set_from(tiles, squares)
    set_tiles = []
    squares.each do |square|
      tile = tiles.find { |tile| tile[:square] == square }
      set_tiles.push(tile)
    end
    set_tiles
  end
end
