# 2 Wordy

# Hint: to solve this problem elegantly, you need to know how the send method works in Ruby. If you haven't seen it before, check it out here.

# Input: string
# Output: integer
# Rules: could be negative integer. Raises argument error if less than 2 integers.
# Problem: accumulate the final solution. 
# potential issues: divided by - float? divided by zero? 
# DS: string, array
# Algo: 
# WordProblem class with instantiation with string argument. Answer is a method or instance variable (@answer, set to 0)
# calculate instance method: made up of different instance methods:
# - store final in @answer.
# - break up string into array of strings. select for numbers or equation phrase. convert digits into integers.
# - iterate over set with accumulating strategy, maybe with reduce, sending and accumulating final answer in @answer
# answer getter method: calculate, then @answer

class WordProblem
  EQUATION_WORDS = {'plus' => '+', 'divided' => '/', 'minus' => '-', 'multiplied'  => '*'}

  def initialize(phrase)
    @phrase = phrase
    @answer = 0
  end

  def answer
    calculate
    @answer
  end

  private

  def calculate
    find_valid_words
    raise ArgumentError if @equation.size < 3
    format_words
    accumulate
  end

  def find_valid_words
    @equation = @phrase.split(' ').select do |word|
      word.match(/\d/) || EQUATION_WORDS[word]
    end
  end

  def format_words
    @equation.map! do |word|
      EQUATION_WORDS[word] ? EQUATION_WORDS[word] : word.scan(/-?\d/).join.to_i
    end
  end

  def accumulate
    @answer = @equation.shift.send(@equation.shift, @equation.shift)
    while !@equation.empty?
      @answer = @answer.send(@equation.shift, @equation.shift)
    end    
  end
end


require 'minitest/autorun'
# require_relative 'wordy'

class WordProblemTest < Minitest::Test
  def test_add_1
    assert_equal 2, WordProblem.new('What is 1 plus 1?').answer
  end

  def test_add_2
    # skip
    assert_equal 55, WordProblem.new('What is 53 plus 2?').answer
  end

  def test_add_negative_numbers
    # skip
    assert_equal(-11, WordProblem.new('What is -1 plus -10?').answer)
  end

  def test_add_more_digits
    # skip
    assert_equal 45_801, WordProblem.new('What is 123 plus 45678?').answer
  end

  def test_subtract
    # skip
    assert_equal 16, WordProblem.new('What is 4 minus -12?').answer
  end

  def test_multiply
    # skip
    assert_equal(-75, WordProblem.new('What is -3 multiplied by 25?').answer)
  end

  def test_divide
    # skip
    assert_equal(-11, WordProblem.new('What is 33 divided by -3?').answer)
  end

  def test_add_twice
    # skip
    question = 'What is 1 plus 1 plus 1?'
    assert_equal 3, WordProblem.new(question).answer
  end

  def test_add_then_subtract
    # skip
    question = 'What is 1 plus 5 minus -2?'
    assert_equal 8, WordProblem.new(question).answer
  end

  def test_subtract_twice
    # skip
    question = 'What is 20 minus 4 minus 13?'
    assert_equal 3, WordProblem.new(question).answer
  end

  def test_subtract_then_add
    # skip
    question = 'What is 17 minus 6 plus 3?'
    assert_equal 14, WordProblem.new(question).answer
  end

  def test_multiply_twice
    # skip
    question = 'What is 2 multiplied by -2 multiplied by 3?'
    assert_equal(-12, WordProblem.new(question).answer)
  end

  def test_add_then_multiply
    # skip
    question = 'What is -3 plus 7 multiplied by -2?'
    assert_equal(-8, WordProblem.new(question).answer)
  end

  def test_divide_twice
    # skip
    question = 'What is -12 divided by 2 divided by -3?'
    assert_equal 2, WordProblem.new(question).answer
  end

  def test_too_advanced
    # skip
    assert_raises ArgumentError do
      WordProblem.new('What is 53 cubed?').answer
    end
  end

  def test_irrelevant
    # skip
    assert_raises ArgumentError do
      WordProblem.new('Who is the president of the United States?').answer
    end
  end
end
