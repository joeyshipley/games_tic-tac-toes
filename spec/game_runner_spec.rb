require 'spec_helper'

describe GameRunner do
  before(:each) do
    @ux_interactor = double("console_interactor")
    @ux_interactor.stub(:draw)
    @ux_interactor.stub(:receive_input).and_return("1")
    @message_provider = double("game_message_provider")
    @message_provider.stub(:game_start)
    @message_provider.stub(:ask_for_human_move)
    @message_provider.stub(:move_already_taken)
    @game_runner = GameRunner.new @ux_interactor, @message_provider
  end

  describe "When the game starts" do
    it "tells the human that they are playing tic-tac-toe" do
      @message_provider.should_receive(:game_start).once
      @game_runner.start
    end

    it "shows the human the tic-tac-toe board" do
      @game_runner.should_receive(:game_board_to_s).once
      @game_runner.start
    end

    it "asks the human to make a move" do
      @message_provider.should_receive(:ask_for_human_move).once
      @game_runner.start
    end
  end

  describe "When the game runner displays a message" do
    it "sends the message to the console" do
      @ux_interactor.should_receive(:draw)
      @game_runner.start
    end
  end

  describe "When the game board is drawn" do
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
    it "give the human the ability to choose their move" do
      @ux_interactor.should_receive(:receive_input).once.with(any_args)
      @game_runner.start
    end
  end

  describe "When the human provides a move" do
    describe "and the move is valid" do
      it "will display the move as an X" do
        @ux_interactor.should_receive(:receive_input).and_return("1")
        @game_runner.start
        result = @game_runner.game_board_to_s

        patternMatch = result =~ /X.*2.*3.*4.*5.*6.*7.*8.*9/m
        hasDisplayedBoardCorrectly = patternMatch.nil? ? false : true
        hasDisplayedBoardCorrectly.should == true
      end
    end

    describe "and the move has already been taken" do
      before(:each) do
        @game_runner.update_move(1, :computer)
        @ux_interactor.should_receive(:receive_input).and_return("1")
      end

      it "will display a validation message" do
        @message_provider.should_receive(:move_already_taken).once
        @game_runner.start
      end

      it "will not update the owner" do
        @game_runner.start
        move = @game_runner.moves.find{ |move| move.square == 1 }
        move.owner.should equal(:computer)
      end
    end

    describe "and the move is not a valid board move" do
      it "will display a validation messave for a response that was empty" do
        @ux_interactor.should_receive(:receive_input).and_return("")
        @message_provider.should_receive(:invalid_move).once
        @game_runner.start

        selected_moves = @game_runner.moves.select { |move| move.owner != :none }
        selected_moves.length.should equal(0)
      end

      it "will display a validation message for a number out of the range" do
        @ux_interactor.should_receive(:receive_input).and_return("0")
        @message_provider.should_receive(:invalid_move).once
        @game_runner.start

        selected_moves = @game_runner.moves.select { |move| move.owner != :none }
        selected_moves.length.should equal(0)
      end

      it "will display a validation message for a non-number" do
        @ux_interactor.should_receive(:receive_input).and_return("A")
        @message_provider.should_receive(:invalid_move).once
        @game_runner.start

        selected_moves = @game_runner.moves.select { |move| move.owner != :none }
        selected_moves.length.should equal(0)
      end
    end
  end

  describe "When the computer has a move applied" do
    it "will display the move as an O" do
      @game_runner.update_move(1, :computer)
      result = @game_runner.game_board_to_s

      patternMatch = result =~ /O.*2.*3.*4.*5.*6.*7.*8.*9/m
      hasDisplayedBoardCorrectly = patternMatch.nil? ? false : true
      hasDisplayedBoardCorrectly.should == true
    end
  end
end
