require 'spec_helper'

describe GameEngine do

  let(:engine) { GameEngine.new }
  let!(:runner) { double("game_runner") }

  describe 'When starting the game' do
    before(:each) do
      GameRunner.stub(:new) { runner }
      runner.stub(:start)
      engine.stub(:output)
    end

    describe "before it performs the first turn" do
      it 'asks what language you want to play the game in' do
        engine.should_receive(:ask_for_language)
        engine.should_receive(:input)
        engine.start
      end
    end

    describe "and the player chooses english" do
      it 'uses the english content' do
        engine.should_receive(:create_english_provider)
        engine.stub(:input) { "" }
        engine.start
      end
    end

    describe "and the player chooses spanish" do
      it 'uses the spanish content' do
        engine.should_receive(:create_spanish_provider)
        engine.stub(:input) { "2" }
        engine.start
      end
    end
  end
end
