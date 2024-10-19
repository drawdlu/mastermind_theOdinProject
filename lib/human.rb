# frozen_string_literal: true

require_relative 'player'

module Mastermind
  # Handle computer decisions
  class HumanPlayer < Player
    def guess_colors
      choose_colors
    end

    def choose_colors
      puts "These are the available colors #{COLORS.map(&:upcase).join(', ')}"
      guesses = []
      TO_GUESS.times do |count|
        print "Choose color #{count + 1}: "
        guess = format_guess(gets.chomp)
        COLORS.include?(guess) ? guesses.push(guess) : redo
      end
      guesses
    end

    def format_guess(guess)
      guess.strip.downcase.to_sym
    end

    def to_s
      'Player'
    end
  end
end
