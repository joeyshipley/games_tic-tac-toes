require 'spec_helper'

describe GameRunner do

  let(:runner) { GameRunner.new(ConsoleInterface.new) }
  let!(:board) { GameBoard.new }
  let!(:game_status) { GameStatusAlgorithm.new([ :player, :computer ]) }
  let!(:ai) { ComputerAiAlgorithm.new(game_status) }

  before(:each) do
    GameBoard.stub(:new) { board }
    GameStatusAlgorithm.stub(:new) { game_status }
    ComputerAiAlgorithm.stub(:new) { ai }

    runner.stub(:output) # tests get cluttered from the actual 'puts' calls.
    runner.stub(:input) { "1" }

    board.stub(:is_tile_available) { true }
    board.stub(:is_tile_valid) { true }
    board.stub(:apply_move)

    game_status.stub(:check_status).and_return(:player)
    ai.stub(:calculate) { "1" }
  end

  describe "During a game turn" do
    it "shows us the board" do
      runner.should_receive(:display_board)
      runner.perform_turn
    end

    it "asks the player for their move" do
      runner.should_receive(:ask_for_player_move)
      runner.perform_turn
    end

    it "waits for the players input" do
      runner.should_receive(:input)
      runner.perform_turn
    end
  end

  describe "When asking the player for a move" do
    describe "and they don't provide a correct move" do
      it "asks them for another move before continuing" do
        runner.should_receive(:validate_move).twice.and_return(false, true)
        runner.get_choice_from_player
      end
    end

    describe "and they provide a valid move" do
      it "doesn't ask them for another move" do
        runner.should_receive(:validate_move).once.and_return(true)
        runner.get_choice_from_player
      end
    end
  end
  describe "When a move is provided from the player" do
    it "applies the move to the board" do
      runner.stub(:input) { "1" }
      board.should_receive(:apply_move).once.with(:player, "1")
      runner.perform_player_action
    end

    describe "that has already been taken" do
      it "lets us know that it has been taken" do
        runner.should_receive(:is_move_available).and_return(false, true)
        runner.should_receive(:message_for_move_already_taken)
        runner.perform_turn
      end
    end

    describe "that is not a legitimate move" do
      it "lets us know that it was not a valid tile" do
        runner.should_receive(:is_move_valid).and_return(false, true)
        runner.should_receive(:message_for_invalid_move)
        runner.perform_turn
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

      it "has the computer actually make a move" do
        game_status.stub(:check_status).and_return(:none)
        board.should_receive(:apply_move).once.with(:computer, anything())
        runner.perform_turn
      end
    end
  end
end
