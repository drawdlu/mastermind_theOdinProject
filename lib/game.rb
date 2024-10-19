# frozen_string_literal: true

require 'colorize'

module Mastermind
  TURNS = 12
  TO_GUESS = 4
  NEUTRAL_COLOR = :black
  COLORS = %i[blue green yellow cyan magenta red].freeze
  # Handles game loop
  class Game
    def initialize(maker_class, guesser_class)
      @maker = maker_class.new(self)
      @guesser = guesser_class.new(self)
      @colors = []
      @board = Array.new(TURNS) { Array.new(4, NEUTRAL_COLOR) }
      @clues = Array.new(TURNS) { { red: 0, white: 0 } }
    end

    def start
      @colors = @maker.choose_initial_colors

      TURNS.times do |count|
        guess = @guesser.guess_colors
        place_player_guess(guess, count)
        if @colors == guess
          puts "#{@guesser} has successfully guessed all the colors!"
          return
        end
      end
      puts "#{@guesser} has failed to guess all the colors"
    end

    def place_player_guess(guess, index)
      @board[index] = guess
    end
  end
end
