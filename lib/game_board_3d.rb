require 'game_board'
require 'tiles'

class GameBoard3d
  include GameBoard

  def initialize
    @tiles = Tiles.new
    ("1".."27").each do |i|
      @tiles.push({ :square => i, :owner => :none })
    end

    @tile_set_identifiers = [
      ["1", "2", "3"]
    ]
  end

  def for_display
    board =  '                            '
    board += '               /      /     '
    board += '              /      /      '
    board += '             /      /       '
    board += '      ------ ------ -----   '
    board += '           /      /         '
    board += '          /      /          '
    board += '         /      /           '
    board += '  ------ ------ ------      '
    board += '       /      /             '
    board += '      /      /              '
    board += '     /      /               '
    board += '               /      /     '
    board += '              /      /      '
    board += '             /      /       '
    board += '      ------ ------ -----   '
    board += '           /      /         '
    board += '          /      /          '
    board += '         /      /           '
    board += '  ------ ------ ------      '
    board += '       /      /             '
    board += '      /      /              '
    board += '     /      /               '
    board += '               /      /     '
    board += '              /      /      '
    board += '             /      /       '
    board += '      ------ ------ -----   '
    board += '           /      /         '
    board += '          /      /          '
    board += '         /      /           '
    board += '  ------ ------ ------      '
    board += '       /      /             '
    board += '      /      /              '
    board += '     /      /               '
    board += '                            '

    board
  end
end
