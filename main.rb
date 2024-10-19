# frozen_string_literal: true

require_relative 'lib/game'
require_relative 'lib/computer'

# Starts game
module GameStart
  include Mastermind
  game = Game.new(ComputerPlayer, ComputerPlayer)
  game.start
end
