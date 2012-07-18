require 'spec_helper'

describe "When the game starts" do

  before(:each) do
    @game_runner = GameRunner.new
  end

  it "tells the human that they are playing tic-tac-toe" do
    $stdout.should_receive(:puts).at_least(0).with(/Tic-Tac-Toe/i)
    @game_runner.start
  end

  it "shows the human the tic-tac-toe board" do
  end

  it "asks the human to make a move" do
  end
end
