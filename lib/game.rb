# frozen_string_literal: true

require_relative 'mastermind'
require 'colorize'

module Mastermind
  # Handles game loop
  class Game
    attr_reader :clues, :turn, :guess_log, :code

    include Mastermind

    def initialize(maker_class, breaker_class)
      @maker = maker_class.new(self)
      @breaker = breaker_class.new(self)
      @guess = []
      @code = []
      @guess_log = Array.new(TURNS) { Array.new(4, NEUTRAL_COLOR) }
      @clues = []
      @turn = nil
    end

    def start
      @code = @maker.choose_initial_colors
      p @code
      TURNS.times do |count|
        @turn = count
        @guess = @breaker.guess_colors
        place_player_guess(count)
        if clues[-1][:red] == CODE_SIZE
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
      @clues.push(clue(@code, @guess))
    end
  end
end
