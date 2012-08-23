require 'spec_helper'
require 'helpers/fake_game_status_algorithm'

describe GameRunner do

  let(:runner) { GameRunner.new(ConsoleInterface.new, EnglishCopyProvider.new) }
  let!(:board) { GameBoard.new }
  let!(:game_status) { FakeGameStatusAlgorithm.new([]) }
  let!(:ai) { ComputerAiAlgorithm.new(game_status) }

  before(:each) do
    GameBoard.stub(:new) { board }
    GameStatusAlgorithm.stub(:new) { game_status }
    ComputerAiAlgorithm.stub(:new) { ai }

    runner.stub(:output) # tests get cluttered from the actual 'puts' calls.
    runner.stub(:input) { "1" }
    ai.stub(:calculate) { "1" }
  end

  describe "When running through the game loop" do
    describe "When the game starts" do
      it "will perform a game turn" do
        game_status.set_actions_taken_before_winner(1)
        runner.should_receive(:perform_turn).at_least(1)
        runner.start
      end
    end

    describe "When the game ends" do
      it "shows us the last board" do
        game_status.set_actions_taken_before_winner(1)
        runner.should_receive(:display_board).at_least(2)
        runner.start
      end

      it "shows the winning message" do
        game_status.set_actions_taken_before_winner(1)
        runner.should_receive(:display_winner).at_least(1)
        runner.start
      end
    end

    describe "After a turn has been played through" do
      it "will play more turns until the game is over" do
        game_status.set_actions_taken_before_winner(2)
        runner.should_receive(:perform_turn).at_least(3)
        runner.start
      end

      it "will play more turns until the game is over" do
        game_status.set_actions_taken_before_winner(3)
        runner.should_receive(:perform_turn).at_least(4)
        runner.start
      end

      it "will play more turns until the game is over" do
        game_status.set_actions_taken_before_winner(4)
        runner.should_receive(:perform_turn).at_least(5)
        runner.start
      end
    end
  end
end
