# frozen_string_literal: true

require_relative 'mastermind'
require_relative 'player'

module Mastermind
  # Handle computer decisions
  class HumanPlayer < Player
    def guess_colors
      print_choices
      puts 'Guess 4 colors in order'
      choose_colors
    end

    def choose_initial_colors
      print_choices
      puts 'Create your code (Pick 4 colors in order)'
      choose_colors
    end

    private

    def choose_colors
      chosen_colors = []
      CODE_SIZE.times do |count|
        print "Color #{count + 1}: "
        choice = gets.chomp.downcase
        COLORS.each_with_index do |color, index|
          next unless color.to_s.downcase.slice(0..(choice.length - 1)) == choice

          chosen_colors.push(COLORS[index])
          break
        end
        redo if chosen_colors[count].nil?
      end
      chosen_colors
    end

    def format_color(color)
      color.strip.downcase.to_sym
    end

    def print_choices
      puts "COLORS: #{COLORS.map(&:upcase).join(', ')}"
      puts 'Type first letter..'
    end

    def to_s
      'Player'
    end
  end
end
