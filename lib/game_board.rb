require 'tiles'

module GameBoard
  attr_accessor :tiles
  attr_accessor :center_tile
  attr_reader :tile_set_identifiers

  def available_tiles
    @tiles.available_tiles
  end

  def has_available_tiles?
    self.available_tiles.length > 0
  end

  def is_tile_available(square)
    owner = get_tile_owner(square)
    owner == :none
  end

  def get_tile_owner(square)
    tile = @tiles.get_tile(square)
    tile[:owner]
  end

  def is_tile_valid(square)
    valid_tiles = @tiles.select { |tile| tile[:square] == square }
    valid_tiles.length > 0
  end

  def apply_move(owner, square)
    tile = @tiles.get_tile(square)
    tile[:owner] = owner
  end

  def tile_display(square)
    tile = @tiles.get_tile(square)
    return "X" if tile[:owner] == :player
    return "O" if tile[:owner] == :computer
    return square if tile[:owner] == :none
  end
end
