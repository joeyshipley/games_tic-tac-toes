require 'game_board_2d'
require 'game_board_3d'
require 'algorithms/computer_ai_algorithm'
require 'algorithms/board_3d_ai_algorithm'

class GameRunnerFactory
  def create_2d(ui_interface, players, game_status)
    board = GameBoard2d.new
    ai = ComputerAiAlgorithm.new(game_status)
    return GameRunner.new(ui_interface, board, players, game_status, ai)
  end

  def create_3d(ui_interface, players, game_status)
    board = GameBoard3d.new
    ai = Board3dAiAlgorithm.new(game_status)
    board.apply_move(:computer, board.center_tile)
    return GameRunner.new(ui_interface, board, players, game_status, ai)
  end
end
