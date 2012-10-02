$LOAD_PATH << './lib'

require 'console_interface'
require 'game_engine'
require 'r18n-desktop'
include R18n::Helpers

R18n.default_places = './config/locales/'
R18n.set 'en'

input_interface = ConsoleInterface.new
game_engine = GameEngine.new(input_interface)
game_engine.start
