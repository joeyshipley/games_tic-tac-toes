require 'spec_helper'

describe "When for a message" do
  before(:each) do
    @game_message_provider = GameMessageProvider.new
  end

  describe "that is about the start of the game" do
    it "says something about it being a tic-tac-toe game" do
      result = @game_message_provider.game_start

      pattern_match = result =~ /Tic-Tac-Toe/m
      has_correct_message = pattern_match.nil? ? false : true
      has_correct_message.should == true
    end
  end

  describe "that is about the human needing to perform their move" do
    it "says something about the human picking their move" do
      result = @game_message_provider.ask_for_human_move

      pattern_match = result =~ /(choose a move)|(choose your move)/i
      has_correct_message = pattern_match.nil? ? false : true
      has_correct_message.should == true
    end
  end

  describe "that is about the human has selected an already taken move" do
    it "says something about the move has already been taken" do
      result = @game_message_provider.move_already_taken

      pattern_match = result =~ /already been taken/i
      has_correct_message = pattern_match.nil? ? false : true
      has_correct_message.should == true
    end
  end
end

