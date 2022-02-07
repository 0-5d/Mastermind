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
      # binding.pry
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
          next if bagels[i] == code[j]

          feedback.push('pico')
          picoed_code.push(j)
          break
        end
      end
      feedback
    end
  end
end
# mark_picos doesn't work
# Should probably make a github repo and a new branch before we move on any farther though

include Mastermind

peepee = Game.new(%w[2 4 1 2], %w[3 4 2 3])
peepee.mark_bagels
p peepee.mark_picos
