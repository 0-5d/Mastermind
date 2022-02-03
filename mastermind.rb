# frozen_string_literal: true

require 'pry-byebug'
# come on rubocop
module Mastermind
  # only contains initialization variables for the game for now
  class Game
    attr_accessor :bagels, :code

    def initialize(code)
      @code = code
      #@guess = guess
      @bagels = []
    end

    def perfect_guess?
      guess == code
    end

    def mark_bagels(guess)
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
    # at some point this should probably go in its own class
    def computer_move
      guess = [0, 0, 0, 0]
      guesses = 0
      loop do
        feedback = mark_bagels(guess)
        break if feedback.count('bagel') == 4

        guesses += 1
        4.times do |i|
          guess[i] += 1 unless feedback[i] == 'bagel'
        end
      end
      guesses
    end

    def human_move
      # so human move is easy just computer move except just gets and convert into an array of integers
      guess = gets.chomp.split(' ')
      guess.map!(&:to_i)
      guesses = 0
      4.times do
        feedback = mark_bagels(guess)
        break if feedback.count('bagel') == 4
        p mark_picos
        guesses += 1
        guess = gets.chomp.split(' ')
        guess.map!(&:to_i)
      end
      guesses
    end
  end
end
# pretty sure mark_picos works but I'm not completely sure.

include Mastermind

peepee = Game.new([2, 9, 1, 3])
peepee.mark_bagels([2, 3, 4 ,1])
p peepee.mark_picos
