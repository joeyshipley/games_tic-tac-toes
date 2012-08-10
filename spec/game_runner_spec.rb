require 'spec_helper'

describe GameRunner do

  before(:each) do
    @runner = GameRunner.new
    @runner.stub(:output) # to keep the test runner from being cluttered with the games various 'puts' calls.
  end

  describe "During a game turn" do
    it "shows us the board" do
      @runner.perform_turn

      pattern_match = @runner.ui =~ /1.*2.*3.*4.*5.*6.*7.*8.*9/m
      is_match = pattern_match.nil? ? false : true
      is_match.should equal(true)
    end

    it "asks the player for their move" do
      @runner.perform_turn

      pattern_match = @runner.ui =~ /choose your move/m
      is_match = pattern_match.nil? ? false : true
      is_match.should == true
    end

    it "waits for the players input" do
      @runner.should_receive(:input)
      @runner.perform_turn
    end
  end
end
