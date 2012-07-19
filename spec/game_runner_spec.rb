require 'spec_helper'

describe "When the game starts" do

  before(:each) do
    @game_runner = GameRunner.new
    @game_runner.stub(:display_message)
  end

  it "tells the human that they are playing tic-tac-toe" do
    @game_runner.should_receive(:display_message).once.with(:game_start)
    @game_runner.start
  end

  it "shows the human the tic-tac-toe board" do
    @game_runner.should_receive(:draw_game_board)
    @game_runner.start
  end

  it "asks the human to make a move" do
    @game_runner.should_receive(:display_message).once.with(:ask_for_human_move)
    @game_runner.start
  end
end

describe "When the game runner displays a message" do

  before(:each) do
    @game_runner = GameRunner.new
  end

  it "sends the message to the console" do
    $stdout.should_receive(:puts).at_least(1)
    @game_runner.display_message(:game_start)
  end
end

describe "When the displaying a message" do

  before(:each) do
    @game_runner = GameRunner.new
  end

  describe "that is about the start of the game" do
    it "says something about it being a tic-tac-toe game" do
      $stdout.should_receive(:puts).once.with(/Tic-Tac-Toe/i)
      @game_runner.display_message(:game_start)
    end
  end

  describe "that is about the human needing to perform their move" do
    it "says something about the human picking their move" do
      $stdout.should_receive(:puts).once.with(/(choose a move)|(choose your move)/i)
      @game_runner.display_message(:ask_for_human_move)
    end
  end
end
