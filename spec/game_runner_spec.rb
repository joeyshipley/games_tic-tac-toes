require 'spec_helper'

describe GameRunner do

  let(:runner) { GameRunner.new }
  let!(:board) { GameBoard.new }
  let!(:game_status) { GameStatusAlgorithm.new }

  before(:each) do
    GameBoard.stub(:new) { board }
    GameStatusAlgorithm.stub(:new) { game_status }

    runner.stub(:output) # tests get cluttered from the actual 'puts' calls.
    runner.stub(:input) { "1" }

    board.stub(:is_tile_available) { true }
    board.stub(:is_tile_valid) { true }
    board.stub(:apply_move)

    game_status.stub(:check_status).and_return(:player)
  end

  describe "During a game turn" do
    it "shows us the board" do
      runner.should_receive(:display_board)
      runner.perform_turn
    end

    it "asks the player for their move" do
      runner.stub(:output) do |arg|
        @ui = arg
      end
      runner.perform_turn
      @ui.should match /choose your move/
    end

    it "waits for the players input" do
      runner.should_receive(:input)
      runner.perform_turn
    end
  end

  describe "When a move is provided from the player" do
    it "applies the move to the board" do
      runner.stub(:input) { "1" }
      board.should_receive(:apply_move).once.with(:player, "1")
      runner.perform_turn
    end

    describe "that has already been taken" do
      it "lets us know that it has been taken" do
        runner.stub(:output) do |arg|
          @ui = arg
        end

        runner.stub(:is_move_available) { false }
        runner.perform_turn
        @ui.should match /already been taken/
      end
    end

    describe "that is not a legitimate move" do
      it "lets us know that it was not a valid tile" do
        runner.stub(:output) do |arg|
          @ui = arg
        end

        runner.stub(:is_move_valid) { false }
        runner.perform_turn
        @ui.should match /invalid choice/
      end
    end

    describe "When it is the computers turn" do
      describe "and the player had won the game" do
        it "does not make the computers move" do
          game_status.stub(:check_status).and_return(:player)
          board.should_not_receive(:apply_move).with(:computer, anything())
          runner.perform_turn
        end
      end

      describe "and the players move was not valid" do
        it "does not make the computers move" do
          game_status.stub(:check_status).and_return(:none)
          board.should_not_receive(:apply_move).with(:computer, anything())
          runner.stub(:is_move_valid) { false }
          runner.perform_turn
        end
      end

      it "has the computer actually make a move" do
        game_status.stub(:check_status).and_return(:none)
        board.should_receive(:apply_move).once.with(:computer, anything())
        runner.perform_turn
      end

      it "only performs a move that is available" do
        game_status.stub(:check_status).and_return(:none)
        board.tiles[0][:owner] = :player
        board.should_receive(:apply_move).once.with(:computer, /[2-9]/)
        runner.perform_turn
      end
    end
  end
end
