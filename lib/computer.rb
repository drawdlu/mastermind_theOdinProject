# frozen_string_literal: true

require_relative 'player'

module Mastermind
  # Handle computer decisions
  class ComputerPlayer < Player
    def choose_initial_colors
      COLORS.sample(4)
    end
  end
end
