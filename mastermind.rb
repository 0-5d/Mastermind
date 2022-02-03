# frozen_string_literal: true

require 'pry-byebug'
# come on rubocop
module Mastermind
  # only contains initialization variables for the game for now
  class Game
    attr_accessor :guess, :bagels, :code

    def initialize(guess, code)
      @code = code
      @guess = guess
      @bagels = []
    end

    def perfect_guess?
      guess == code
    end

    def mark_bagels
      4.times do |i|
        if guess[i] == code[i]
          bagels.push('bagel')
          next
        end
        bagels.push(guess[i])
      end
      bagels
    end

    def mark_picos
      feedback = []
      picoed_code = []
      picoed = false
      bageled = false
      4.times do |i|
        if bagels[i] == 'bagel'
          feedback.push('bagel')
          next
        end
        4.times do |j|
          bageled = false
          bageled = true if bagels[j] == 'bagel'
          picoed_code.each do |x|
            next unless x == j

            picoed = true
            break
          end
          next unless !picoed && !bageled

          picoed = false
          bageled = false
          if bagels[i] == code[j]
            feedback.push('pico')
            picoed_code.push(j)
            break
          end
          feedback.push(bagels[i])
          break
        end
      end
      feedback
    end
  end
end
# pretty sure mark_picos works but I'm not completely sure.
# Should probably make a github repo and a new branch before we move on any farther though

include Mastermind

peepee = Game.new(%w[2 4 1 4], %w[2 4 1 3])
peepee.mark_bagels
p peepee.mark_picos
