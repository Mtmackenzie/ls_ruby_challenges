# 6 Anagrams
# Write a program that, given a word and a list of possible anagrams, selects the correct sublist that contains the anagrams of the word.

# For example, given the word "listen" and a list of candidates like "enlists" "google" "inlets" "banana" the program should return a list containing "inlets". Please read the test suite for exact rules of anagrams.

# Input: string and given array
# Output: array
# Rules: if none, return empty array. sorted? case insensitive. don't include identical word in final list. make sure to return unique list of anagrams.
# Problem: iterate over given array and see if the words contain the same amount of letters as the given string. return words that are the same in a new array.
# 
# Algo: 
# define a class called Anagram that takes a word as an argument. store word in instance var @word
# define instnace method #match that takes an array as an argument
#-select all the words that have the same amount of letters downcased as original.
# - have the same value sorted

class Anagram
  def initialize(word)
    @given_word = word
  end

  def match(arr)
    anagrams = []
    arr.each do |word|
      if !anagrams.include?(word) && word.downcase.chars.sort == @given_word.downcase.chars.sort
        anagrams << word unless @given_word.downcase == word.downcase
      end
    end
    anagrams.sort
  end
end

require 'minitest/autorun'
# require_relative 'anagram'

class AnagramTest < Minitest::Test
  def test_no_matches
    detector = Anagram.new('diaper')
    assert_equal [], detector.match(%w(hello world zombies pants))
  end

  def test_detect_simple_anagram
    # skip
    detector = Anagram.new('ant')
    anagrams = detector.match(%w(tan stand at))
    assert_equal ['tan'], anagrams
  end

  def test_detect_multiple_anagrams
    # skip
    detector = Anagram.new('master')
    anagrams = detector.match(%w(stream pigeon maters))
    assert_equal %w(maters stream), anagrams.sort
  end

  def test_does_not_confuse_different_duplicates
    # skip
    detector = Anagram.new('galea')
    assert_equal [], detector.match(['eagle'])
  end

  def test_identical_word_is_not_anagram
    # skip
    detector = Anagram.new('corn')
    anagrams = detector.match %w(corn dark Corn rank CORN cron park)
    assert_equal ['cron'], anagrams
  end

  def test_eliminate_anagrams_with_same_checksum
    # skip
    detector = Anagram.new('mass')
    assert_equal [], detector.match(['last'])
  end

  def test_eliminate_anagram_subsets
    # skip
    detector = Anagram.new('good')
    assert_equal [], detector.match(%w(dog goody))
  end

  def test_detect_anagram
    # skip
    detector = Anagram.new('listen')
    anagrams = detector.match %w(enlists google inlets banana)
    assert_equal ['inlets'], anagrams
  end

  def test_multiple_anagrams
    # skip
    detector = Anagram.new('allergy')
    anagrams =
      detector.match %w( gallery ballerina regally clergy largely leading)
    assert_equal %w(gallery largely regally), anagrams.sort
  end

  def test_anagrams_are_case_insensitive
    # skip
    detector = Anagram.new('Orchestra')
    anagrams = detector.match %w(cashregister Carthorse radishes)
    assert_equal ['Carthorse'], anagrams
  end
end
