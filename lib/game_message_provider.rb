class GameMessageProvider
  def game_start
    return "Welcome to a friendly game of Tic-Tac-Toe."
  end

  def ask_for_human_move
    return "Please choose a move."
  end

  def move_already_taken
    return "Sorry, that move has already been taken, please try another."
  end
end
