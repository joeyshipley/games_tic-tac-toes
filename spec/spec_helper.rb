$:.unshift File.dirname(__FILE__), "../app"
# don't know why the previous path include stopped working.
# changed the filename from game to game_runner and it just stopped loading the
# file.
$:.unshift File.dirname(__FILE__), ""
$:.unshift File.dirname(__FILE__), "app"
$:.unshift File.dirname(__FILE__), "/app"
$:.unshift File.dirname(__FILE__), "./app"

require 'rspec'

# because there was no expectation that I would have gotten those to work
require './app/game_runner.rb'
