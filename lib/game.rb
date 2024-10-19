# frozen_string_literal: true

require 'colorize'

module Mastermind
  TURNS = 12
  TO_GUESS = 4
  COLORS = %i[blue green yellow cyan magenta red].freeze
  # Handles game loop
  class Game
    def initialize(maker_class, guesser_class)
      @maker = maker_class.new(self)
      @guesser = guesser_class.new(self)
      @colors = []
      @board = Array.new(TURNS) { Array.new(TO_GUESS) }
      @clues = Array.new(TURNS) { { red: 0, white: 0 } }
    end

    def start
      @colors = @maker.choose_colors
    end
  end
end
