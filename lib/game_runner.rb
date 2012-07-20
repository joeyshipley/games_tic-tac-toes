class GameRunner
  # current responsibilities:
  # 1. manages running the game
  # 2. determines what message to display
  # 3. turning a game board into a displayable format
  def initialize(ux_interactor)
    @ux_interactor = ux_interactor
  end

  def start
    send_to_display :game_start
    send_to_display :game_board
    send_to_display :ask_for_human_move
    @ux_interactor.receive_input
  end

  def send_to_display(msg_type)
    @ux_interactor.draw "Welcome to a friendly game of Tic-Tac-Toe" if msg_type == :game_start
    @ux_interactor.draw "Please choose a move." if msg_type == :ask_for_human_move
    @ux_interactor.draw game_board_to_s if msg_type == :game_board
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
