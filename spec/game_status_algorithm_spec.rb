require 'spec_helper'

describe GameStatusAlgorithm do

  let(:status_algo) { GameStatusAlgorithm.new([ :player, :computer ]) }
  let(:board) { GameBoard.new }

  describe "When checking to see who the winner is" do

    describe "and no one has won" do
      it "lets us know that no one has won the game." do
        result = status_algo.check_status(board)
        result.should equal(:none)
      end

      it "there was a tie" do
        board.apply_move(:player, "1")
        board.apply_move(:computer, "2")
        board.apply_move(:player, "3")
        board.apply_move(:computer, "7")
        board.apply_move(:player, "4")
        board.apply_move(:computer, "6")
        board.apply_move(:player, "5")
        board.apply_move(:computer, "9")
        board.apply_move(:player, "8")

        result = status_algo.check_status(board)
        result.should equal(:draw)
      end
    end


    describe "and we want to make sure that any player can win" do
      it "allows the player to win" do
        assert_wins_with(:player, %w{ 1 2 3 })
      end

      it "allows the computer to win" do
        assert_wins_with(:computer, %w{ 1 2 3 })
      end
    end

    describe "and someone has a set on a row" do
      it "lets us know that each of the sets can be won from" do
        board.tile_set_identifiers.each do |set|
          assert_wins_with(:player, set)
        end
      end
    end
  end

  def assert_wins_with(owner, moves)
    apply_moves(owner, moves)
    result = status_algo.check_status(board)
    result.should equal(owner)
  end

  def apply_moves(owner, moves)
    moves.each { |move| board.apply_move(owner, move) }
  end
end

