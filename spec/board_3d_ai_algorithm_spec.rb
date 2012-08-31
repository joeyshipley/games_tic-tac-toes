require 'spec_helper'

describe Board3dAiAlgorithm do

  let(:ai) { Board3dAiAlgorithm.new(status) }
  let!(:status) { GameStatusAlgorithm.new([ :player, :computer ]) }
  let(:board) { GameBoard3d.new }

  describe "When choosing the computers move" do

    describe "When a winning move is available" do
      it "takes the winning move" do
        board.apply_move(:computer, "2")
        board.apply_move(:computer, "11")
        result = ai.calculate(board)
        result.should == "20"
      end
    end

    describe "When asking for the computers first move" do
      it "returns the center tile" do
        result = ai.calculate(board)
        result.should == "14"
      end
    end

    describe "When asking for additional moves" do
      def apply_player_move_and_calculate(square)
        board.apply_move(:player, square)
        ai.calculate(board)
      end

      before(:each) do
        board.apply_move(:computer, board.center_tile)
      end

      describe "and there is a set of moves picked out" do
        it "returns one of those moves if they are available" do
          board.apply_move(:player, "1")
          result = ai.calculate(board)
          result.should == "22"
        end

        it "returns one of those moves if they are available" do
          board.apply_move(:player, "1")
          board.apply_move(:computer, ai.calculate(board))
          board.apply_move(:player, "6")
          result = ai.calculate(board)
          result.should == "13"
        end
      end

      describe "and the players first move was 1, 7, 10, or 16" do
        it "chooses its moves from the correct set" do
          apply_player_move_and_calculate("1")
          ai.move_set.should == ["22", "13"]
        end

        it "chooses its moves from the correct set" do
          apply_player_move_and_calculate("7")
          ai.move_set.should == ["22", "13"]
        end

        it "chooses its moves from the correct set" do
          apply_player_move_and_calculate("10")
          ai.move_set.should == ["22", "13"]
        end

        it "chooses its moves from the correct set" do
          apply_player_move_and_calculate("16")
          ai.move_set.should == ["22", "13"]
        end
      end

      describe "and the players first move was 19 or 25" do
        it "chooses its moves from the correct set" do
          apply_player_move_and_calculate("19")
          ai.move_set.should == ["4", "13"]
        end

        it "chooses its moves from the correct set" do
          apply_player_move_and_calculate("25")
          ai.move_set.should == ["4", "13"]
        end
      end

      describe "and the players first move was 3, 9, 12, or 18" do
        it "chooses its moves from the correct set" do
          apply_player_move_and_calculate("3")
          ai.move_set.should == ["24", "15"]
        end

        it "chooses its moves from the correct set" do
          apply_player_move_and_calculate("9")
          ai.move_set.should == ["24", "15"]
        end

        it "chooses its moves from the correct set" do
          apply_player_move_and_calculate("12")
          ai.move_set.should == ["24", "15"]
        end

        it "chooses its moves from the correct set" do
          apply_player_move_and_calculate("18")
          ai.move_set.should == ["24", "15"]
        end
      end

      describe "and the players first move was 21 or 27" do
        it "chooses its moves from the correct set" do
          apply_player_move_and_calculate("21")
          ai.move_set.should == ["6", "15"]
        end

        it "chooses its moves from the correct set" do
          apply_player_move_and_calculate("27")
          ai.move_set.should == ["6", "15"]
        end
      end

      describe "and the players first move was 4, 8, 13, or 17" do
        it "chooses its moves from the correct set" do
          apply_player_move_and_calculate("4")
          ai.move_set.should == ["25", "16"]
        end

        it "chooses its moves from the correct set" do
          apply_player_move_and_calculate("8")
          ai.move_set.should == ["25", "16"]
        end

        it "chooses its moves from the correct set" do
          apply_player_move_and_calculate("13")
          ai.move_set.should == ["25", "16"]
        end

        it "chooses its moves from the correct set" do
          apply_player_move_and_calculate("17")
          ai.move_set.should == ["25", "16"]
        end
      end

      describe "and the players first move was 22 or 26" do
        it "chooses its moves from the correct set" do
          apply_player_move_and_calculate("22")
          ai.move_set.should == ["7", "16"]
        end

        it "chooses its moves from the correct set" do
          apply_player_move_and_calculate("26")
          ai.move_set.should == ["7", "16"]
        end
      end

      describe "and the players first move was 2, 6, 11, or 15" do
        it "chooses its moves from the correct set" do
          apply_player_move_and_calculate("2")
          ai.move_set.should == ["21", "12"]
        end

        it "chooses its moves from the correct set" do
          apply_player_move_and_calculate("6")
          ai.move_set.should == ["21", "12"]
        end

        it "chooses its moves from the correct set" do
          apply_player_move_and_calculate("11")
          ai.move_set.should == ["21", "12"]
        end

        it "chooses its moves from the correct set" do
          apply_player_move_and_calculate("15")
          ai.move_set.should == ["21", "12"]
        end
      end

      describe "and the players first move was 20 or 24" do
        it "chooses its moves from the correct set" do
          apply_player_move_and_calculate("20")
          ai.move_set.should == ["3", "12"]
        end

        it "chooses its moves from the correct set" do
          apply_player_move_and_calculate("24")
          ai.move_set.should == ["3", "12"]
        end
      end

      describe "and the players first move was 5" do
        it "chooses its moves from the correct set" do
          apply_player_move_and_calculate("5")
          ai.move_set.should == ["1", "10"]
        end
      end

      describe "and the players first move was 23" do
        it "chooses its moves from the correct set" do
          apply_player_move_and_calculate("23")
          ai.move_set.should == ["19", "10"]
        end
      end
    end
  end
end
