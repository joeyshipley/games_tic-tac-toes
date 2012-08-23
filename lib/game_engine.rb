require 'game_runner'
require 'console_interface'
require 'internationalization/english_copy_provider'
require 'internationalization/spanish_copy_provider'

class GameEngine
  def initialize
    @interface = ConsoleInterface.new
  end

  def start
    ask_for_language
    choice = input

    text_provider = get_internationalization choice
    game_runner = GameRunner.new(@interface, text_provider)
    game_runner.start
  end

  def ask_for_language
    output "To continue in English, press [Enter] or [1]"
    output "Para continuar en espanol, presione [2]"
  end

  def get_internationalization(choice)
    return create_spanish_provider if choice.eql? "2"
    return create_english_provider
  end

  def create_english_provider
    EnglishCopyProvider.new
  end

  def create_spanish_provider
    SpanishCopyProvider.new
  end

  def output(message)
    @interface.output message
  end

  def input
    @interface.input
  end
end
