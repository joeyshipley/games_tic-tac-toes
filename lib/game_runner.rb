class GameRunner
  def start
    display_message(:game_start)
    draw_game_board
    display_message(:ask_for_human_move)
  end

  def display_message(msg_type)
    puts "Welcome to a friendly game of Tic-Tac-Toe" if msg_type == :game_start
    puts "Please choose a move." if msg_type == :ask_for_human_move
  end

  def draw_game_board

  end
end
