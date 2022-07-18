# Entire game of Master Mind when initialized starts game
class MasterMind
  def initialize
    @game = Game.new
    @game.create_code
  end
end

# This is the code for the master mind game giving turns
class Game
  def initialize
    @turns = 12
  end

  def create_code
    @code = [rand(1..4).to_i, rand(1..4).to_i, rand(1..4).to_i, rand(1..4).to_i]
    p @code
    round
  end

  def computer_round
    puts "Enter a 4 digit number for the computer to guess \n Possible numbers include 1,2,3,4"
    @code = gets.chomp
    ai = rand(1..4).to_i
    r = Round.new(@code, ai)
    until r.computercheck || @turns.zero
      @turns -= 1
      r.guess = rand (1..4).to_i
    end
    puts @turns <= 0 ? 'You Win /n Computer Lost' : 'You lost /n Computer Wins'
  end

  def player_input
    puts "You have #{@turns} turns"
    puts "Enter a 4 digit number for code guess \n Possible numbers include 1,2,3,4"
    gets.chomp
  end

  def player_round
    attempt = player_input
    r = Round.new(@code, attempt)
    until r.playercheck || @turns.zero
      @turns -= 1
      info = r.count(@code)
      puts "You got #{info[0]} incorrect and #{info[1]} correct"
      attempt = player_input
      r.guess = attempt.to_s
    end
    puts @turns <= 0 ? 'You Lose' : 'You Win'
  end

  def round
    valid = %w[Creator Guessor]
    puts 'Enter the role you desire for this game Creator or Guessor'
    rmode = gets.chomp
    until valid.include?(rmode)
      puts 'Invalid Creator or Guessor'
      rmode = gets.chomp
    end
    rmode == 'Guessor' ? player_round : computer_round
  end
end

# plays one Round of mastermind
class Round
  attr_accessor :guess

  def initialize(code, guess)
    @answer = code
    @guess = guess
  end

  def count(code)
    # @guess = guess.split("").map{|value| value.to_i}
    errors = 0
    correct = 0
    @guess.length.times { |i| @guess[i] == code[i] ? correct += 1 : errors += 1 }
    [errors, correct]
  end

  def playercheck
    @guess = guess.split('').map { `&:to_i` }
    @answer == @guess
  end

  def computercheck
    @answer == @guess
  end
end
MasterMind.new
