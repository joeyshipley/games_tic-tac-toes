class GameRunner
  def start
    display_message(:game_start)
    display_game_board
    display_message(:ask_for_human_move)
  end

  def display_message(msg_type)
    draw "Welcome to a friendly game of Tic-Tac-Toe" if msg_type == :game_start
    draw "Please choose a move." if msg_type == :ask_for_human_move
  end

  def display_game_board
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

    draw board
  end

  def draw(message)
    puts message
  end
end
