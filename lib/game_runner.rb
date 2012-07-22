class GameRunner
  # current responsibilities:
  # 1. manages running the game
  # 2. turning a game board into a displayable format
  def initialize(ux_interactor, game_message_provider)
    @ux_interactor = ux_interactor
    @message_provider = game_message_provider
  end

  def start
    @ux_interactor.draw @message_provider.game_start
    @ux_interactor.draw game_board_to_s
    @ux_interactor.draw @message_provider.ask_for_human_move
    @ux_interactor.receive_input
  end

  def game_board_to_s
    board = ""
    board += "                   \n"
    board += "      |     |      \n"
    board += "   1  |  2  |  3   \n"
    board += "      |     |      \n"
    board += " ----- ----- ----- \n"
    board += "      |     |      \n"
    board += "   4  |  5  |  6   \n"
    board += "      |     |      \n"
    board += " ----- ----- ----- \n"
    board += "      |     |      \n"
    board += "   7  |  8  |  9   \n"
    board += "      |     |      \n"
    board += "                   \n"

    return board
  end
end
