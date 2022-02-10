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
      @bagels = []
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
      mark_bagels
      feedback = {}
      picoed_code = []
      picoed = false
      bageled = false
      #binding.pry
      4.times do |i|
        if bagels[i] == 'bagel'
          feedback[i] = 'bagel'
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
          next unless bagels[i] == code[j]

          # binding.pry
          feedback[i] = 'pico'
          picoed_code.push(j)
          break
        end
      end
      feedback
    end



  end
  def computer_guess
    code = gets.chomp.split(' ')
    code.map!(&:to_i)
    game = Game.new([0, 0, 0, 0], code)
    guesses = 0

    loop do
      p game.guess
      feedback = game.mark_bagels

      break if feedback.count('bagel') == 4

      guesses += 1
      4.times do |i|
        game.guess[i] += 1 unless feedback[i] == 'bagel'
      end
    end
    guesses
  end

  def human_guess
    guess = gets.chomp.split(' ')
    guess.map!(&:to_i)
    game = Game.new(guess, [rand(10), rand(10), rand(10), rand(10)])
    p game.code
    2.times do
      #binding.pry
      p game.mark_picos
      break if game.bagels.count('bagel') == 4

      game.guess = gets.chomp.split(' ')
      game.guess.map!(&:to_i)
    end
  end
end
# pretty sure mark_picos works but I'm not completely sure.
# Should probably make a github repo and a new branch before we move on any farther though

include Mastermind

#peepee = Game.new([0,1,2,0], [0,0,0,2])
#p peepee.mark_picos

human_guess