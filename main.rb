# frozen_string_literal: true

require_relative 'lib/game'
require_relative 'lib/computer'
require_relative 'lib/human'

# Starts game
module GameStart
  include Mastermind
  game = Game.new(ComputerPlayer, HumanPlayer)
  game.start
end
