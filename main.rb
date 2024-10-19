# frozen_string_literal: true

require_relative 'lib/game'
require_relative 'lib/computer'
require_relative 'lib/human'

# Starts game
module GameStart
  include Mastermind

  choice = nil
  until %w[m b].include?(choice)
    print 'Choose your role: ("m" for code maker and "b" for code breaker) '
    choice = gets.chomp.downcase
  end

  case choice
  when 'm'
    maker = HumanPlayer
    breaker = ComputerPlayer
  else
    breaker = HumanPlayer
    maker = ComputerPlayer
  end

  game = Game.new(maker, breaker)
  game.start
end
