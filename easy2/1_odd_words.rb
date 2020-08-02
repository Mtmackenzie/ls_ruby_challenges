# - words, space, point
# - words at most 20 chars
# - text could have 1+ words separated by 1+ spaces, end with 0+ spaces and point
# - input has spaces at the front? if so, ignore spaces and start with first letter of first word
# - returned string should only have one space in between words and period at the end
# - odd words are reversed, even not. words that are at odd indices (if it was an array)

# Input: string
# Output: string
# Rules: odd index words are reversed and extra spaces are removed.
# Problem: looking for groups of characters (words) and iterate over those groups and for odd words(index), reverse.
# DS: strings, array
# 
# Algo: 
# class Text. objects will have string instance variable that contains string object.
# remove period? break the string into an array of words, iterate over the words and for odd indexed words reverse the characters, join back together as a string with a period at the end.
# test cases:
# make sure period is at the end when the last word is an odd index !!!
# make sure only odd indexed words are reversed
# make sure only one space in between words, for both input strings with lots of spaces before and in between and after
# make sure works for only one word
# make sure it works for long words
# make sure final output is a string object

require 'minitest/autorun'

class Text
  attr_accessor :string
  def initialize(string)
    @string = string
  end

  def reverse_odd_words
    period = @string.slice!(-1)
    @string.split(' ').map.with_index do |word, idx|
      idx.odd? ? word.reverse : word
    end.join(' ') + period
  end
end

class TextTest < Minitest::Test
  def setup
    @text = Text.new("whats the matter with kansas.")
  end

  def test_reverse_odd_words
    expected = "whats eht matter htiw kansas."
    assert_equal(expected, @text.reverse_odd_words)
  end

  def test_one_word
    word = Text.new("word.")
    assert_equal("word.", word.reverse_odd_words)
  end

  def test_with_extra_spaces
    sentence = Text.new("   hello      hi    .")
    assert_equal("hello ih.", sentence.reverse_odd_words)
  end

  def test_period_present_at_end
    assert_equal(".", @text.reverse_odd_words[-1])
  end

  def test_is_a_string
    assert_instance_of(String, @text.reverse_odd_words)
  end

  def test_period_at_end_if_last_word_odd
    text = Text.new("hello hi.")
    assert_equal(".", text.reverse_odd_words[-1])
  end

  def test_long_words
    text = Text.new('abcdefghijkl abcdefghijk.')
    assert_equal('abcdefghijkl kjihgfedcba.', text.reverse_odd_words)
  end
end