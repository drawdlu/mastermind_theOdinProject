# frozen_string_literal: true

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

    def choose_colors
      chosen_colors = []
      CODE_SIZE.times do |count|
        print "Color #{count + 1}: "
        color = format_color(gets.chomp)
        COLORS.include?(color) ? chosen_colors.push(color) : redo
      end
      chosen_colors
    end

    def format_color(color)
      color.strip.downcase.to_sym
    end

    def print_choices
      puts "COLORS: #{COLORS.map(&:upcase).join(', ')}"
    end

    def to_s
      'Player'
    end
  end
end
