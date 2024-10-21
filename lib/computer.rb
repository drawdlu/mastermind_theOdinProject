# frozen_string_literal: true

require_relative 'mastermind'
require_relative 'player'

module Mastermind
  # Handle computer decisions
  class ComputerPlayer < Player
    include Mastermind

    def initialize(game)
      super(game)
      @possibility_index = (0..5).to_a.repeated_permutation(4).to_set
    end

    def choose_initial_colors
      random = []
      CODE_SIZE.times { random.push(COLORS.sample) }
      random
    end

    def guess_colors
      return [COLORS[0], COLORS[0], COLORS[1], COLORS[1]] if @game.clues.empty?

      remove_possibilities
    end

    def remove_possibilities
      prev_clue = @game.clues[-1]
      prev_guess = @game.guess_log[@game.turn - 1]
      @possibility_index.each do |p|
        p_color = [COLORS[p[0]], COLORS[p[1]], COLORS[p[2]], COLORS[p[3]]]
        p_clue = clue(prev_guess, p_color)
        @possibility_index.delete(p) unless prev_clue == p_clue
      end
    end

    def to_s
      'Computer'
    end
  end
end
