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
        board.apply_move(:player, "7")
        board.apply_move(:computer, "1")
        board.apply_move(:player, "4")
        board.apply_move(:computer, "2")
        board.apply_move(:player, "9")

        result = ai.calculate(board)
        result.should match /3/
      end

      it "will return the move that the computer should take to win the game" do
        board.apply_move(:player, "1")
        board.apply_move(:computer, "2")
        board.apply_move(:player, "3")
        board.apply_move(:computer, "5")
        board.apply_move(:player, "4")

        result = ai.calculate(board)
        result.should match /8/
      end
    end

    describe "and the player can win the game" do
      it "will return the blocking move" do
        board.apply_move(:player, "1")
        board.apply_move(:computer, "3")
        board.apply_move(:player, "5")

        result = ai.calculate(board)
        result.should match /9/
      end
    end

    describe "and the player plays a corner for their first move" do
      it "will not choose an edge" do
        board.apply_move(:player, "1")

        result = ai.calculate(board)
        result.should_not match /(2|4|6|8)/
      end
    end

    describe "in the scenerio where a player can create the corner double win sets" do
      it "will choose an edge" do
        board.apply_move(:player, "1")
        board.apply_move(:computer, "5")
        board.apply_move(:player, "9")

        result = ai.calculate(board)
        result.should match /(2|4|6|8)/
      end

      it "will not choose the opposite corner" do
        board.apply_move(:player, "1")

        result = ai.calculate(board)
        result.should_not match /9/
      end
    end
  end
end
