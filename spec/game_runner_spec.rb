require 'spec_helper'

describe GameRunner do

  let(:runner) { GameRunner.new }
  let!(:board) { GameBoard.new }

  before(:each) do
    GameBoard.stub(:new) { board }
    runner.stub(:output) # to keep the test runner from being cluttered with the games various 'puts' calls.
    runner.stub(:input) { "1" }
  end

  describe "During a game turn" do
    it "shows us the board" do
      runner.perform_turn

      pattern_match = runner.ui =~ /1.*2.*3.*4.*5.*6.*7.*8.*9/m
      is_match = pattern_match.nil? ? false : true
      is_match.should equal(true)
    end

    it "asks the player for their move" do
      runner.perform_turn

      pattern_match = runner.ui =~ /choose your move/m
      is_match = pattern_match.nil? ? false : true
      is_match.should == true
    end

    it "waits for the players input" do
      runner.should_receive(:input)
      runner.perform_turn
    end
  end

  describe "When a move is provided from the player" do
    it "applies the move to the board" do
      runner.stub(:input) { "1" }
      board.should_receive(:apply_move).with(:player, 1)
      runner.perform_turn
    end
  end
end
