class Tiles < Array
  def owned_tiles
    self.select { |tile|  tile }
  end
end
