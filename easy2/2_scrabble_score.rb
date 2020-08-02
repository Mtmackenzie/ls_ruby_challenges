# 2 Scrabble Score

# Input: 
# Output: 
# Rules: nil = 0, empty string/whitespaces = 0. other letters = score.
# Problem: iterate over each of the keys of the letters hash, iterate over each letter and count the amount of times it appears in the given word, then multiply this times the value and add to final score.
# 
# DS: string, hash (array from the hash)
# 
# Algo: 
# make all the input words uppercase to be able to compare
# init lv final_score
# nil: make a guard clause at the beginning
# iterate over the keys of the hash, iterate over the letters.
# count the amount of times the letter appears in the word, multiply it times the current value, add to final score
# return final score at the end
# whitespaces: yes

# refactor idea: make a letters class? that has letter and score instance variables.

# Scrabble object with string input, #score method returns an integer object
# can handle whitespaces
# can handle empty string
# can handle either case (in the method, make all the input words uppercase)
# input of nil is 0
# can handle one letter
# can handle multiple letters
# can handle words with multiple letters
# class method that does the same thing ???

class Scrabble
  LETTERS = {%w(A, E, I, O, U, L, N, R, S, T) => 1, %w(D, G) => 2, %w(B, C, M, P) => 3, %w(F, H, V, W, Y) => 4, %w(K) => 5, %w(J, X) => 8, %w(Q, Z) => 10}

  def initialize(word)
    @word = word
  end

  def score
    return 0 unless @word
    word = @word.upcase
    final_score = 0
    LETTERS.each do |set, points|
      set.each do |letter|
        final_score += (word.count(letter) * points)
      end
    end
    final_score
  end

  def self.score(word)
    new(word).score
  end
end

require 'minitest/autorun'
# require_relative 'scrabble_score'

class ScrabbleTest < Minitest::Test
  def test_empty_word_scores_zero
    assert_equal 0, Scrabble.new('').score
  end

  def test_whitespace_scores_zero
    # skip
    assert_equal 0, Scrabble.new(" \t\n").score
  end

  def test_nil_scores_zero
    # skip
    assert_equal 0, Scrabble.new(nil).score
  end

  def test_scores_very_short_word
    # skip
    assert_equal 1, Scrabble.new('a').score
  end

  def test_scores_other_very_short_word
    # skip
    assert_equal 4, Scrabble.new('f').score
  end

  def test_simple_word_scores_the_number_of_letters
    # skip
    assert_equal 6, Scrabble.new('street').score
  end

  def test_complicated_word_scores_more
    # skip
    assert_equal 22, Scrabble.new('quirky').score
  end

  def test_scores_are_case_insensitive
    # skip
    assert_equal 41, Scrabble.new('OXYPHENBUTAZONE').score
  end

  def test_convenient_scoring
    # skip
    assert_equal 13, Scrabble.score('alacrity')
  end
end