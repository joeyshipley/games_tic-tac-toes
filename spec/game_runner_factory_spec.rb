require 'spec_helper'

describe GameRunnerFactory do

  let(:factory) { GameRunnerFactory.new }
  let!(:board2d) { GameBoard2d.new }
  let!(:board3d) { GameBoard3d.new }
  let(:interface) { double("ui_interface") }
  let(:players) { double("players") }
  let(:game_status) { double("game_status") }

  before(:each) do
    GameBoard2d.stub(:new) { board2d }
    GameBoard3d.stub(:new) { board3d }
  end

  describe "When creating a game runner" do

    describe "for a 2d game" do
      it "uses the 2d board and the NegaMax algorithm" do
        GameBoard2d.should_receive(:new)
        ComputerAiAlgorithm.should_receive(:new)
        GameRunner.should_receive(:new)
        factory.create_2d(interface, players, game_status)
      end
    end

    describe "for a 3d game" do
      it "uses the 3d board and the 3d ai algorithm" do
        GameBoard3d.should_receive(:new)
        Board3dAiAlgorithm.should_receive(:new)
        GameRunner.should_receive(:new)
        factory.create_3d(interface, players, game_status)
      end

      it "applies the computers first move as the boards center tile" do
        board3d.should_receive(:apply_move).with(:computer, "14")
        factory.create_3d(interface, players, game_status)
      end
    end
  end
end
