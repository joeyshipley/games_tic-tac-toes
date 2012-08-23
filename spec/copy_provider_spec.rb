require 'spec_helper'

describe EnglishCopyProvider do

  let(:text_provider) { EnglishCopyProvider.new }

  describe "When asking for a move to be choosen" do
    it "Displays the correct text" do
      result = text_provider.ask_for_player_move
      result.should match /choose your move/
    end
  end

  describe "When informing that the player made an invalid choice" do
    it "Displays the correct text" do
      result = text_provider.invalid_move_message
      result.should match /invalid choice/
    end
  end

  describe "When informing the player about a move that has already been taken" do
    it "Displays the correct text" do
      result = text_provider.move_already_taken_message
      result.should match /already been taken/
    end
  end

  describe "When letting the player know that someone has won the game" do
    it "Displays the correct text for a player win" do
      result = text_provider.game_status_winner_text(:player)
      result.should match /player has won/
    end

    it "Displays the correct text for a computer win" do
      result = text_provider.game_status_winner_text(:computer)
      result.should match /computer has won/
    end

    it "Displays the correct text for a tie game" do
      result = text_provider.game_status_winner_text(:draw)
      result.should match /a tie/
    end
  end
end

describe SpanishCopyProvider do

  let(:text_provider) { SpanishCopyProvider.new }

  describe "When asking for a move to be choosen" do
    it "Displays the correct text" do
      result = text_provider.ask_for_player_move
      result.should match /elija su mudanza/
    end
  end

  describe "When informing that the player made an invalid choice" do
    it "Displays the correct text" do
      result = text_provider.invalid_move_message
      result.should match /eso fue una eleccion valida/
    end
  end

  describe "When informing the player about a move that has already been taken" do
    it "Displays the correct text" do
      result = text_provider.move_already_taken_message
      result.should match /el movimiento ya ha sido tomada/
    end
  end

  describe "When letting the player know that someone has won the game" do
    it "Displays the correct text for a player win" do
      result = text_provider.game_status_winner_text(:player)
      result.should match /jugador/
    end

    it "Displays the correct text for a computer win" do
      result = text_provider.game_status_winner_text(:computer)
      result.should match /equipo/
    end

    it "Displays the correct text for a tie game" do
      result = text_provider.game_status_winner_text(:draw)
      result.should match /juego era un empate/
    end
  end
end
