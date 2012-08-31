require 'game_runner'
require 'console_interface'
require 'game_board_2d'
require 'game_board_3d'
require 'algorithms/game_status_algorithm'
require 'algorithms/computer_ai_algorithm'
require 'algorithms/board_3d_ai_algorithm'

class GameEngine
  def initialize
    @interface = ConsoleInterface.new
    @players = [ :player, :computer ]
    @game_status = GameStatusAlgorithm.new(@players)
  end

  def start
    ask_for_language
    language_choice = input
    set_internationalization language_choice

    ask_for_game_type
    game_type_choice = input

    game_runner = build_game_runner(game_type_choice)
    game_runner.start
  end

  private

  def ask_for_language
    output t.messages.choose_language
  end

  def set_internationalization(choice)
    return set_spanish_provider if choice.eql? "2"
    return set_english_provider
  end

  def set_english_provider
    R18n.set 'en'
  end

  def set_spanish_provider
    R18n.set 'es'
  end

  def ask_for_game_type
    output t.messages.choose_game_type
  end

  def build_game_runner(choice)
    return build_runner_for_2d unless choice == "3"
    return build_runner_for_3d if     choice == "3"
  end

  def build_runner_for_2d
    board = GameBoard2d.new
    ai = ComputerAiAlgorithm.new(@game_status)
    return GameRunner.new(@interface, board, @players, @game_status, ai)
  end

  def build_runner_for_3d
    board = GameBoard3d.new
    ai = Board3dAiAlgorithm.new(@game_status)
    board.apply_move(:computer, board.center_tile)
    return GameRunner.new(@interface, board, @players, @game_status, ai)
  end

  def output(message)
    @interface.output message
  end

  def input
    @interface.input
  end
end
