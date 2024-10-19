# frozen_string_literal: true

require 'colorize'

module Mastermind
  TURNS = 12
  TO_GUESS = 4
  NEUTRAL_COLOR = :black
  COLORS = %i[blue green yellow cyan magenta red].freeze
  # Handles game loop
  class Game
    def initialize(maker_class, breaker_class)
      @maker = maker_class.new(self)
      @breaker = breaker_class.new(self)
      @guess = []
      @colors = []
      @board = Array.new(TURNS) { Array.new(4, NEUTRAL_COLOR) }
      @clues = []
    end

    def start
      @colors = @maker.choose_initial_colors
      p @colors
      TURNS.times do |count|
        @guess = @breaker.guess_colors
        place_player_guess(count)
        if @colors == @guess
          puts "#{@breaker} has successfully guessed all the colors!"
          return
        end
      end
      puts "#{@breaker} has failed to guess all the colors"
    end

    def place_player_guess(index)
      @board[index] = @guess
      print_board
    end

    def print_board
      print_clues
    end

    def print_clues
      place_clues
      @clues.each do |element|
        element.each { |key, value| value.times { print '|'.send(key) } }
        (TO_GUESS - (element[:red] + element[:white])).times do
          print '|'.send(NEUTRAL_COLOR)
        end
        print ' '
      end
      puts ''
    end

    def place_clues
      @clues.push(clues)
    end

    def clues
      clues_tally = { red: 0, white: 0 }
      @colors.each_with_index do |element, index|
        if element == @guess[index]
          clues_tally[:red] += 1
          @guess[index] = nil
        elsif @guess.include?(element)
          clues_tally[:white] += 1
        end
      end
      clues_tally
    end
  end
end
