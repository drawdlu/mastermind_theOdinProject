# frozen_string_literal: true

require_relative 'player'

module Mastermind
  # Handle computer decisions
  class ComputerPlayer < Player
    def choose_initial_colors
      random = []
      TO_GUESS.times { random.push(COLORS.sample) }
      random
    end

    def to_s
      'Computer'
    end
  end
end
