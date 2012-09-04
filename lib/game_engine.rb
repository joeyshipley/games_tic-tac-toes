require 'game_runner'
require 'game_runner_factory'
require 'console_interface'
require 'algorithms/game_status_algorithm'

class GameEngine
  def initialize
    @game_runner_factory = GameRunnerFactory.new
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
    @game_runner_factory.create_2d(@interface, @players, @game_status)
  end

  def build_runner_for_3d
    @game_runner_factory.create_3d(@interface, @players, @game_status)
  end

  def output(message)
    @interface.output message
  end

  def input
    @interface.input
  end
end
