require 'spec_helper'

describe "When the game starts" do

  before(:each) do
    @game_runner = GameRunner.new
    @game_runner.stub(:send_to_display)
  end

  it "tells the human that they are playing tic-tac-toe" do
    @game_runner.should_receive(:send_to_display).once.with(:game_start)
    @game_runner.start
  end

  it "shows the human the tic-tac-toe board" do
    @game_runner.should_receive(:send_to_display).once.with(:game_board)
    @game_runner.start
  end

  it "asks the human to make a move" do
    @game_runner.should_receive(:send_to_display).once.with(:ask_for_human_move)
    @game_runner.start
  end
end

describe "When the game runner displays a message" do

  before(:each) do
    @game_runner = GameRunner.new
  end

  it "sends the message to the console" do
    @game_runner.should_receive(:draw).at_least(1)
    @game_runner.send_to_display(:game_start)
  end
end

describe "When the displaying a message" do

  before(:each) do
    @game_runner = GameRunner.new
  end

  describe "that is about the start of the game" do
    it "says something about it being a tic-tac-toe game" do
      @game_runner.should_receive(:draw).once.with(/Tic-Tac-Toe/i)
      @game_runner.send_to_display(:game_start)
    end
  end

  describe "that is about the human needing to perform their move" do
    it "says something about the human picking their move" do
      @game_runner.should_receive(:draw).once.with(/(choose a move)|(choose your move)/i)
      @game_runner.send_to_display(:ask_for_human_move)
    end
  end
end

describe "When the game board is drawn" do

  before(:each) do
    @game_runner = GameRunner.new
  end

  describe "And no moves have been made yet" do
    it "draws the board with the numeric values" do
      result = @game_runner.game_board_to_s

      patternMatch = result =~ /1.*2.*3.*4.*5.*6.*7.*8.*9/m
      hasDisplayedBoardCorrectly = patternMatch.nil? ? false : true
      hasDisplayedBoardCorrectly.should == true
    end
  end

end

describe "When the game asks the human to provide a move" do

  before(:each) do
    @game_runner = GameRunner.new
  end

  it "give the human the ability to choose their move" do
    @game_runner.should_receive(:accept_input)
    @game_runner.start
  end
end
