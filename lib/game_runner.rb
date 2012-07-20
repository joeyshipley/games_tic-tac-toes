class GameRunner
  # current responsibilities:
  # 1. UI input/output
  # 2. making the game run
  # 3. turning a game board into a displayable format

  def start
    send_to_display :game_start
    send_to_display :game_board
    send_to_display :ask_for_human_move
    human_choice_made = accept_input
  end

  def send_to_display(msg_type)
    draw "Welcome to a friendly game of Tic-Tac-Toe" if msg_type == :game_start
    draw "Please choose a move." if msg_type == :ask_for_human_move
    draw game_board_to_s if msg_type == :game_board
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

  def draw(message)
    puts message
  end

  def accept_input
    return gets.chomp
  end
end
