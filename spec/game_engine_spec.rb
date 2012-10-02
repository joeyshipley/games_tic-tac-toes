require 'spec_helper'

describe GameEngine do

  let(:engine) { GameEngine.new(ConsoleInterface.new) }
  let!(:runner) { double("game_runner") }
  let!(:board3d) { GameBoard3d.new }

  describe 'When starting the game' do
    before(:each) do
      GameRunner.stub(:new) { runner }
      GameBoard3d.stub(:new) { board3d }
      runner.stub(:start)
      engine.stub(:output)
    end

    describe "before it performs the first turn" do
      it 'asks what language you want to play the game in' do
        engine.should_receive(:ask_for_language)
        engine.should_receive(:input).at_least(1)
        engine.start
      end

      it 'asks whether or not they want to play the 2d game or 3d game' do
        engine.should_receive(:ask_for_game_type)
        engine.should_receive(:input).at_least(2)
        engine.start
      end
    end

    describe "and the player chooses english" do
      it 'uses the english content' do
        engine.should_receive(:set_english_provider)
        engine.stub(:input) { "" }
        engine.start
      end
    end

    describe "and the player chooses spanish" do
      it 'uses the spanish content' do
        engine.should_receive(:set_spanish_provider)
        engine.stub(:input) { "2" }
        engine.start
      end
    end

    describe "and the player chooces the" do
      before(:each) do
        @temp_runner = double("game_runner")
        @temp_runner.stub(:start)
      end

      describe "2d game" do
        it "sets up the game to use the 2d components" do
          engine.should_receive(:build_runner_for_2d).and_return(@temp_runner)
          engine.stub(:input).and_return("")
          engine.start
        end
      end

      describe "3d game" do
        it "sets up the game to use the 3d components" do
          engine.should_receive(:build_runner_for_3d).and_return(@temp_runner)
          engine.stub(:input).and_return("3")
          engine.start
        end

        it "the computer makes the first move" do
          board3d.should_receive(:apply_move)
          engine.stub(:input).and_return("3")
          engine.start
        end
      end
    end
  end
end
