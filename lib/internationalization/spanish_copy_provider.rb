class SpanishCopyProvider
  def ask_for_player_move
    'Por favor, elija su mudanza'
  end

  def invalid_move_message
    'Lo siento, eso fue una eleccion valida. Por favor, intentelo de nuevo.'
  end

  def move_already_taken_message
    'Lo sentimos, el movimiento ya ha sido tomada.'
  end

  def game_status_winner_text(winner)

    return 'El jugador ha ganado la partida.' if winner == :player
    return 'El equipo ha ganado la partida.'  if winner == :computer
    return 'El juego era un empate.'          if winner == :draw
  end
end
