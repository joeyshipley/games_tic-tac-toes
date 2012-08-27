$LOAD_PATH << './lib'
require 'game_engine'
require 'r18n-desktop'
include R18n::Helpers

R18n.default_places = './config/locales/'
R18n.set 'en'

game_engine = GameEngine.new
game_engine.start
