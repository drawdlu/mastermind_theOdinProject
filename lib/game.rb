# frozen_string_literal: true

require 'colorize'

module Mastermind
  TURNS = 12
  CODE_SIZE = 4
  NEUTRAL_COLOR = :black
  COLORS = %i[blue green yellow cyan magenta red].freeze

  # Handles game loop
  class Game
    def initialize(maker_class, breaker_class)
      @maker = maker_class.new(self)
      @breaker = breaker_class.new(self)
      @guess = []
      @code = []
      @guess_log = Array.new(TURNS) { Array.new(4, NEUTRAL_COLOR) }
      @clues = []
    end

    def start
      @code = @maker.choose_initial_colors
      p @code
      TURNS.times do |count|
        @guess = @breaker.guess_colors
        place_player_guess(count)
        if @code == @guess_log[count]
          puts "#{@breaker} has successfully guessed all the colors!"
          return
        end
      end
      puts "#{@breaker} has failed to guess all the colors"
    end

    def place_player_guess(index)
      @guess_log[index] = @guess.clone
      print_board
    end

    def print_board
      print_clues
      index = 0
      4.times do
        @guess_log.each do |element|
          print '●    '.send(element[index])
        end
        puts ''
        index += 1
      end
    end

    def print_clues
      place_clues
      @clues.each do |hash|
        hash.each { |key, value| value.times { print '|'.send(key) } }
        (CODE_SIZE - (hash[:red] + hash[:white])).times do
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
      @code.each_with_index do |color, index|
        if color == @guess[index]
          clues_tally[:red] += 1
          guess_to_nil(index)
        elsif guess_has?(color)
          clues_tally[:white] += 1
        end
      end
      clues_tally
    end

    # check for a guess index that is not equal to a corresponding index in code
    def guess_has?(color)
      indexes = @guess.each_index.select { |e| @guess[e] == color }
      indexes.each do |index|
        unless @code[index] == @guess[index]
          guess_to_nil(index)
          return true
        end
      end
      false
    end

    def guess_to_nil(index)
      @guess[index] = nil
    end
  end
end
