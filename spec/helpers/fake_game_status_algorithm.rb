class FakeGameStatusAlgorithm < GameStatusAlgorithm
  def initialization
    @count = 0
    @rounds = 0
  end

  def set_actions_taken_before_winner(rounds)
    @count = 0
    @rounds = rounds
  end

  def check_status(board, players)
    return :player if @count >= @rounds

    @count += 1
    return :none
  end
end

