# frozen_string_literal: true

require_relative 'mastermind'
require_relative 'player'

module Mastermind
  # Handle computer decisions
  class ComputerMaker < Player
    include Mastermind

    def choose_initial_colors
      random = []
      CODE_SIZE.times { random.push(COLORS.sample) }
      random
    end

    def to_s
      'Computer'
    end
  end
end
