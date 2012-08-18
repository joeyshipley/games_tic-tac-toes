class Tiles < Array
  def get_tile(location)
    self.find { |tile| tile[:square] == location }
  end

  def owned_tiles(owner)
    self.select { |tile| tile[:owner] == owner }
  end

  def available_tiles
    self.select { |tile| tile[:owner] == :none }
  end
end

