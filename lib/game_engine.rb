require 'game_runner'
require 'console_interface'

class GameEngine
  def initialize
    @interface = ConsoleInterface.new
  end

  def start
    ask_for_language
    choice = input
    set_internationalization choice

    game_runner = GameRunner.new(@interface)
    game_runner.start
  end

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

  def output(message)
    @interface.output message
  end

  def input
    @interface.input
  end
end
