require 'spec_helper'

describe "When for a message" do
  before(:each) do
    @game_message_provider = GameMessageProvider.new
  end

  describe "that is about the start of the game" do
    it "says something about it being a tic-tac-toe game" do
      result = @game_message_provider.game_start

      patternMatch = result =~ /Tic-Tac-Toe/m
      hasCorrectMessage = patternMatch.nil? ? false : true
      hasCorrectMessage.should == true
    end
  end

  describe "that is about the human needing to perform their move" do
    it "says something about the human picking their move" do
      result = @game_message_provider.ask_for_human_move

      patternMatch = result =~ /(choose a move)|(choose your move)/i
      hasCorrectMessage = patternMatch.nil? ? false : true
      hasCorrectMessage.should == true
    end
  end
end

