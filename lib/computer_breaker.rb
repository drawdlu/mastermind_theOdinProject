# frozen_string_literal: true

require_relative 'mastermind'
require_relative 'player'
require_relative 'computer_maker'

module Mastermind
  # Handle computer decisions
  class ComputerBreaker < ComputerMaker
    include Mastermind

    INITIAL_GUESS = [0, 0, 1, 1].freeze

    def initialize(game)
      super(game)

      @guesses = []
      @all_possibilities = (0..LAST_INDEX).to_a.repeated_permutation(4).to_a
      @possibilities = @all_possibilities.dup.to_set
      @all_clues = {}
      @all_possibilities.product(@all_possibilities) do |code, guess|
        @all_clues[code] = {} unless @all_clues.key?(code)
        @all_clues[code][guess] = clue(code, guess)
      end
    end

    def guess_colors
      if @game.clues.empty?
        guess = INITIAL_GUESS
      else
        remove_possibilities
        guess = @all_possibilities[max_score_index]
      end
      @guesses.push(guess)
      color_array(guess)
    end

    private

    def remove_possibilities
      prev_clue = @game.clues[-1]
      prev_guess = @game.guess_log[@game.turn - 1]

      @possibilities.each do |p|
        p_clue = clue(prev_guess, color_array(p))
        @possibilities.delete(p) unless prev_clue == p_clue
      end
    end

    def color_array(color_arr)
      [COLORS[color_arr[0]],
       COLORS[color_arr[1]],
       COLORS[color_arr[2]],
       COLORS[color_arr[3]]]
    end

    def max_score_index
      all_scores = []
      remaining = @possibilities.length
      return @all_possibilities.find_index(@possibilities.to_a[0]) if remaining == 1

      @all_possibilities.each do |code|
        score = get_score(code, remaining)
        all_scores.push(score)
      end
      all_scores.find_index(all_scores.max)
    end

    def get_score(code, remaining)
      if @guesses.include?(code)
        0
      else
        score(code, remaining)
      end
    end

    def score(code, remaining)
      tally = {}
      @possibilities.each do |guess|
        clues = @all_clues[code][guess]
        tally.key?(clues) ? tally[clues] += 1 : tally[clues] = 1
      end
      remaining - tally_max(tally)
    end

    def tally_max(tally)
      tally.max_by(&:last)[1]
    end

    def to_s
      'Computer'
    end
  end
end
