# 8 Word Count
# Write a program that given a phrase can count the occurrences of each word in that phrase.
# Input: phrase (stored in instance variable)
# Output: hash with words as keys and number of occurrences as values. keys only once. 
# Rules: ignore punctuation but phrase could be separated by punctuation without spaces. could have string numbers. case insensitive. could have apostrophes. could be in quotations.
# Problem: split downcased phrase up into words (separated by anything that's not an alphanumeric character, ignoring apostrophes. iterate over the array and for every word, add to hash with running count of how many times it appears (check to see if included - if yes, increment value by 1, if not, add to hash with value of 1)
# Algo: 
# define a Phrase class with phrase value.
# format the phrase to make into an array with the following criteria: downcased, could be string numbers, words could be separated by commas or spaces, words do not include punctuation including quotations except for apostrophes and only legitimate apostrophes.
# instance method word_count
  # iterate over the array and for every word, add to hash with running count of how many times it appears (check to see if included - if yes, increment value by 1, if not, add to hash with value of 1)
# remove punctuation method: pass in string as argument. 
# - replace every non alphanumeric character with a space except for apostrophes
# - valid_apostrophe?
# - 

class Phrase
  ALPHANUMERIC = ('a'..'z').to_a + ('0'..'9').to_a + ["'"]

  def initialize(phrase)
    @phrase = phrase.downcase
  end

  def word_count
    @phrase = remove_punctuation
    words = {}
    @phrase.split(' ').each do |word|
      if words.keys.include?(word)
        words[word] += 1
      else
        words[word] = 1
      end
    end
    words
  end

  def remove_punctuation
    @phrase = @phrase.chars.map.with_index do |char, idx| 
      if char == "'"
        valid_apostrophe?(idx) ? "'" :  ' '
      else
        ALPHANUMERIC.include?(char) ? char : ' '
      end
    end.join
  end

  def valid_apostrophe?(idx)
    ALPHANUMERIC.include?(@phrase[idx - 1]) && ALPHANUMERIC.include?(@phrase[idx + 1])
  end
end

require 'minitest/autorun'
# require_relative 'word_count'

class PhraseTest < Minitest::Test
  def test_count_one_word
    phrase = Phrase.new('word')
    counts = { 'word' => 1 }
    assert_equal counts, phrase.word_count
  end

  def test_count_one_of_each
    # skip
    phrase = Phrase.new('one of each')
    counts = { 'one' => 1, 'of' => 1, 'each' => 1 }
    assert_equal counts, phrase.word_count
  end

  def test_count_multiple_occurrences
    # skip
    phrase = Phrase.new('one fish two fish red fish blue fish')
    counts = { 'one' => 1, 'fish' => 4, 'two' => 1, 'red' => 1, 'blue' => 1 }
    assert_equal counts, phrase.word_count
  end

  def test_count_everything_just_once
    # skip
    phrase = Phrase.new('all the kings horses and all the kings men')
    phrase.word_count # count it an extra time
    counts = {
      'all' => 2, 'the' => 2, 'kings' => 2,
      'horses' => 1, 'and' => 1, 'men' => 1
    }
    assert_equal counts, phrase.word_count
  end

  def test_ignore_punctuation
    # skip
    phrase = Phrase.new('car : carpet as java : javascript!!&@$%^&')
    counts = {
      'car' => 1, 'carpet' => 1, 'as' => 1,
      'java' => 1, 'javascript' => 1
    }
    assert_equal counts, phrase.word_count
  end

  def test_handles_cramped_lists
    # skip
    phrase = Phrase.new('one,two,three')
    counts = { 'one' => 1, 'two' => 1, 'three' => 1 }
    assert_equal counts, phrase.word_count
  end

  def test_handles_expanded_lists
    # skip
    phrase = Phrase.new("one,\ntwo,\nthree")
    counts = { 'one' => 1, 'two' => 1, 'three' => 1 }
    assert_equal counts, phrase.word_count
  end

  def test_include_numbers
    # skip
    phrase = Phrase.new('testing, 1, 2 testing')
    counts = { 'testing' => 2, '1' => 1, '2' => 1 }
    assert_equal counts, phrase.word_count
  end

  def test_normalize_case
    # skip
    phrase = Phrase.new('go Go GO')
    counts = { 'go' => 3 }
    assert_equal counts, phrase.word_count
  end

  def test_with_apostrophes
    # skip
    phrase = Phrase.new("First: don't laugh. Then: don't cry.")
    counts = {
      'first' => 1, "don't" => 2, 'laugh' => 1,
      'then' => 1, 'cry' => 1
    }
    assert_equal counts, phrase.word_count
  end

  def test_with_quotations
    # skip
    phrase = Phrase.new("Joe can't tell between 'large' and large.")
    counts = {
      'joe' => 1, "can't" => 1, 'tell' => 1,
      'between' => 1, 'large' => 2, 'and' => 1
    }
    assert_equal counts, phrase.word_count
  end
end