require 'spec_helper'

describe 'GameBoard' do
  before(:each) do
    @runner = GameRunner.new
    @board = @runner.board
  end

  describe "When we need the board to be displayed" do
    describe "and no moves have been made" do
      it "displays only the numeric values of the moves" do
        pattern_match = @board.for_display =~ /1.*2.*3.*4.*5.*6.*7.*8.*9/m
        is_match = pattern_match.nil? ? false : true
        is_match.should equal(true)
      end
    end
  end

  describe "When the players move is 1" do
    it "applies the players move to the game board" do
      @board.apply_move(:player, 1)
      move_owner = @board.get_move_owner(1)
      move_owner.should equal(:player)
    end
  end

  describe "When the computer move is 1" do
    it "applies the computers move to the game board" do
      @board.apply_move(:computer, 1)
      move_owner = @board.get_move_owner(1)
      move_owner.should equal(:computer)
    end
  end
end
