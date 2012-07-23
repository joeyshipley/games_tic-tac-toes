class Move
  attr_accessor :square
  attr_accessor :owner

  def initialize( square, owner )
    @square = square
    @owner = owner
  end
end
