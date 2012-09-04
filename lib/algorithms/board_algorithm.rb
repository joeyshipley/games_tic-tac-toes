module BoardAlgorithm
  def copy(board, owner, square)
    board_copy = Marshal::load(Marshal.dump(board))
    board_copy.apply_move(owner, square)
    board_copy
  end
end
