# frozen_string_literal: true

# Mastermind game
module Mastermind
  TURNS = 12
  CODE_SIZE = 4
  NEUTRAL_COLOR = :black
  COLORS = %i[blue green yellow cyan magenta red].freeze

  def clue(color_code, player_guess)
    guess = player_guess.clone
    clue_tally = { red: 0, white: 0 }
    color_code.each_with_index do |color, index|
      if color == guess[index]
        clue_tally[:red] += 1
        guess[index] = nil
      elsif guess_has?(color_code, guess, color)
        clue_tally[:white] += 1
      end
    end
    clue_tally
  end

  # check for a guess index that is not equal to a corresponding index in code
  def guess_has?(color_code, guess, color)
    indexes = guess.each_index.select { |e| guess[e] == color }
    indexes.each do |index|
      unless color_code[index] == guess[index]
        guess[index] = nil
        return true
      end
    end
    false
  end
end
