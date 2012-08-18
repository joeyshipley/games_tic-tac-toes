require 'spec_helper'

describe ComputerAiAlgorithm do

  let!(:game_status) { GameStatusAlgorithm.new([ :player, :computer ]) }
  let(:ai) { ComputerAiAlgorithm.new(game_status) }
  let(:board) { GameBoard.new }

  before(:each) do
    GameStatusAlgorithm.stub(:new) { game_status }
  end

  describe "When calculating a move" do
    describe "and the computer can win the game" do
      it "will return the move that the computer should take to win the game" do
        board.apply_move(:computer, "1")
        board.apply_move(:computer, "2")

        result = ai.calculate(board)
        result.should match /3/
      end

      it "will return the move that the computer should take to win the game" do
        board.apply_move(:computer, "2")
        board.apply_move(:computer, "5")

        result = ai.calculate(board)
        result.should match /8/
      end

      it "will return the move that the computer should take to win the game" do
        board.apply_move(:computer, "1")
        board.apply_move(:computer, "5")

        result = ai.calculate(board)
        result.should match /9/
      end
    end

    describe "and the player can win the game" do
      it "will return the blocking move" do
        board.apply_move(:player, "4")
        board.apply_move(:player, "5")

        result = ai.calculate(board)
        result.should match /6/
      end
    end
  end
end
