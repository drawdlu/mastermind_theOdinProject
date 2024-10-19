# frozen_string_literal: true

require_relative 'player'

module Mastermind
  # Handle computer decisions
  class HumanPlayer < Player
    def guess_colors
      puts "COLORS: #{COLORS.map(&:upcase).join(', ')}"
      choose_colors
    end

    def choose_initial_colors
      choose_colors
    end

    def choose_colors
      puts "These are the available colors #{COLORS.map(&:upcase).join(', ')}"
      chosen_colors = []
      CODE_SIZE.times do |count|
        print "Choose color #{count + 1}: "
        color = format_color(gets.chomp)
        COLORS.include?(color) ? chosen_colors.push(color) : redo
      end
      chosen_colors
    end

    def format_color(color)
      color.strip.downcase.to_sym
    end

    def to_s
      'Player'
    end
  end
end
