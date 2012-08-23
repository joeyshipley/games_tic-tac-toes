class EnglishCopyProvider
  def ask_for_player_move
    'Please choose your move:'
  end

  def invalid_move_message
    'Sorry, that was an invalid choice. Please try again.'
  end

  def move_already_taken_message
    'Sorry the move has already been taken.'
  end

  def game_status_winner_text(winner)
    return "The #{winner} has won the game."  unless  winner == :draw
    return "Game was a tie."                  if      winner == :draw
  end
end
