require 'spec_helper'

describe 'GameBoard' do
  let(:board2d) { GameBoard2d.new }
  let(:board3d) { GameBoard3d.new }

  describe "When we need the 3d board to be displayed" do
    describe "and no moves have been made" do
      it "displays only the numeric values of the moves" do
        board3d.for_display.should match /1.*2.*3.*4.*5.*6.*7.*8.*9.*10.*11.*12.*13.*14.*15.*16.*17.*18.*19.*20.*21.*22.*23.*24.*25.*26.*27/m
      end
    end

    it "displays a move from a tile that was higher than 10 with padding" do
      board3d.apply_move(:player, "10")
      result = board3d.tile_display_for_potential_multi_digits("10")
      result.should == ' X'
    end
  end

  describe "When we need the 2d board to be displayed" do
    describe "and no moves have been made" do
      it "displays only the numeric values of the moves" do
        board2d.for_display.should match /1.*2.*3.*4.*5.*6.*7.*8.*9/m
      end
    end

    it "displays the player as an X" do
      board2d.apply_move(:player, "1")
      result = board2d.tile_display("1")
      result.should == 'X'
    end

    it "displays the computer as an O" do
      board2d.apply_move(:computer, "1")
      result = board2d.tile_display("1")
      result.should == 'O'
    end

    describe "and the player has made a move" do
      it "displays the tile the player has chosen as the players" do
        board2d.apply_move(:player, "1")
        tile_display = board2d.tile_display("1")
        result = board2d.for_display
        result.should match /#{tile_display}.*2.*3.*4.*5.*6.*7.*8.*9/m
      end
    end

    describe "and the computer has made a move" do
      it "displays the tile the computer has chosen as the computers" do
        board2d.apply_move(:computer, "1")
        tile_display = board2d.tile_display("1")
        result = board2d.for_display
        result.should match /#{tile_display}.*2.*3.*4.*5.*6.*7.*8.*9/m
      end
    end
  end

  describe "When the players move is 1" do
    it "applies the players move to the game board" do
      board2d.apply_move(:player, "1")
      move_owner = board2d.get_tile_owner("1")
      move_owner.should == :player
    end
  end

  describe "When the computer move is 1" do
    it "applies the computers move to the game board" do
      board2d.apply_move(:computer, "1")
      move_owner = board2d.get_tile_owner("1")
      move_owner.should == :computer
    end
  end

  describe "When validating a move" do
    describe "that has already been taken" do
      it "returns that it is not valid" do
        board2d.apply_move(:player, "1")
        result = board2d.is_tile_available("1")
        result.should == false
      end
    end

    describe "that is a letter" do
      it "returns that it is not valid" do
        result = board2d.is_tile_valid("A")
        result.should == false
      end
    end

    describe "that is out of the tile range" do
      it "returns that it is not valid" do
        result = board2d.is_tile_valid("0")
        result.should == false
      end
    end
  end
end
