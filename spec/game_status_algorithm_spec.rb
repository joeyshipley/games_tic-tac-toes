require 'spec_helper'

describe GameStatusAlgorithm do

  let(:status_algo) { GameStatusAlgorithm.new }
  let(:board) { GameBoard.new }

  describe "When checking to see who the winner is" do

    describe "and no one has won" do
      it "lets us know that no one has won the game." do
        result = status_algo.check_status(board)
        result.should equal(:none)
      end
    end

    describe "and the player has a set on a row" do
      it "lets us know that the player has won the game from the first row" do
        board.apply_move(:player, "1")
        board.apply_move(:player, "2")
        board.apply_move(:player, "3")

        result = status_algo.check_status(board)
        result.should equal(:player)
      end

      it "lets us know that the player has won the game from the second row" do
        board.apply_move(:player, "4")
        board.apply_move(:player, "5")
        board.apply_move(:player, "6")

        result = status_algo.check_status(board)
        result.should equal(:player)
      end

      it "lets us know that the player has won the game from the third row" do
        board.apply_move(:player, "7")
        board.apply_move(:player, "8")
        board.apply_move(:player, "9")

        result = status_algo.check_status(board)
        result.should equal(:player)
      end
    end

    describe "and the computer has a set on a row" do
      it "lets us know that the computer has won the game from the first row" do
        board.apply_move(:computer, "1")
        board.apply_move(:computer, "2")
        board.apply_move(:computer, "3")

        result = status_algo.check_status(board)
        result.should equal(:computer)
      end

      it "lets us know that the computer has won the game from the second row" do
        board.apply_move(:computer, "4")
        board.apply_move(:computer, "5")
        board.apply_move(:computer, "6")

        result = status_algo.check_status(board)
        result.should equal(:computer)
      end

      it "lets us know that the computer has won the game from the third row" do
        board.apply_move(:computer, "7")
        board.apply_move(:computer, "8")
        board.apply_move(:computer, "9")

        result = status_algo.check_status(board)
        result.should equal(:computer)
      end
    end

    describe "and the player has a set on a column" do
      it "lets us know that the player has won the game from the first column" do
        board.apply_move(:player, "1")
        board.apply_move(:player, "4")
        board.apply_move(:player, "7")

        result = status_algo.check_status(board)
        result.should equal(:player)
      end

      it "lets us know that the player has won the game from the second column" do
        board.apply_move(:player, "2")
        board.apply_move(:player, "5")
        board.apply_move(:player, "8")

        result = status_algo.check_status(board)
        result.should equal(:player)
      end

      it "lets us know that the player has won the game from the third column" do
        board.apply_move(:player, "3")
        board.apply_move(:player, "6")
        board.apply_move(:player, "9")

        result = status_algo.check_status(board)
        result.should equal(:player)
      end
    end

    describe "and the computer has a set on a column" do
      it "lets us know that the computer has won the game from the first column" do
        board.apply_move(:computer, "1")
        board.apply_move(:computer, "4")
        board.apply_move(:computer, "7")

        result = status_algo.check_status(board)
        result.should equal(:computer)
      end

      it "lets us know that the computer has won the game from the second column" do
        board.apply_move(:computer, "2")
        board.apply_move(:computer, "5")
        board.apply_move(:computer, "8")

        result = status_algo.check_status(board)
        result.should equal(:computer)
      end

      it "lets us know that the computer has won the game from the third column" do
        board.apply_move(:computer, "3")
        board.apply_move(:computer, "6")
        board.apply_move(:computer, "9")

        result = status_algo.check_status(board)
        result.should equal(:computer)
      end
    end

    describe "and the player has a set on a a diagonal" do
      it "lets us know that the player has won the game from the first diagonal" do
        board.apply_move(:player, "1")
        board.apply_move(:player, "5")
        board.apply_move(:player, "9")

        result = status_algo.check_status(board)
        result.should equal(:player)
      end

      it "lets us know that the player has won the game from the second diagonal" do
        board.apply_move(:player, "7")
        board.apply_move(:player, "5")
        board.apply_move(:player, "3")

        result = status_algo.check_status(board)
        result.should equal(:player)
      end
    end

    describe "and the computer has a set on a a diagonal" do
      it "lets us know that the computer has won the game from the first diagonal" do
        board.apply_move(:computer, "1")
        board.apply_move(:computer, "5")
        board.apply_move(:computer, "9")

        result = status_algo.check_status(board)
        result.should equal(:computer)
      end

      it "lets us know that the computer has won the game from the second diagonal" do
        board.apply_move(:computer, "7")
        board.apply_move(:computer, "5")
        board.apply_move(:computer, "3")

        result = status_algo.check_status(board)
        result.should equal(:computer)
      end
    end
  end
end
