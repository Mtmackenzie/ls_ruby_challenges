# 1 Palindrome Products
# Write a program that can detect palindrome products in a given range.

# A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers (range 10 ~ 99) is 9009 = 91 x 99.

# Input: 
# Output: 
# Rules: 
# Problem: 
# 
# DS: 
# 
# Algo: 
# Palindrome object with max factor and optional min factor
# instance methods: generate, largest (largest is an object), smallest (same as largest - probably need to sort the Palidromes array by values), value (available to Palidrome objects), factors (array of subarrays with two digits each, could have repeating combos)
# within Palindrome class: find factors
# within Palindromes class: generate list of palidromes from given range


class Palindrome
  attr_reader :value
  def initialize(value, max, min)
    @value = value
    @max = max
    @min = min
    @factors = []
  end

  def factors
    find_factors(@max, @min)
    @factors
  end

  private

  def find_factors(max, min)
    Math.sqrt(value).to_i.downto(min) do |num|
      if value % num == 0
        @factors << [num, value/num] unless value/num > @max
      end
    end
  end
end

class Palindromes
  def initialize(max_factor:, min_factor: 1)
    @max_factor = max_factor
    @min_factor = min_factor
    @palindromes = []
  end

  def generate
    (@min_factor..@max_factor).to_a.repeated_combination(2).each do |set|
      value = set[0] * set[1]
      if value.digits == value.digits.reverse
        @palindromes << Palindrome.new(value, @max_factor, @min_factor) # unless already present
      end
    end
    @palindromes
  end

  def smallest
    @palindromes.sort_by { |obj| obj.value }.first
  end

  def largest
    @palindromes.sort_by { |obj| obj.value }.last
  end
end

require 'minitest/autorun'
# require_relative 'palindrome_products'

class PalindromesTest < Minitest::Test
  def test_largest_palindrome_from_single_digit_factors
    palindromes = Palindromes.new(max_factor: 9)
    palindromes.generate
    largest = palindromes.largest
    assert_equal 9, largest.value
    assert_includes [[[3, 3], [1, 9]], [[1, 9], [3, 3]]], largest.factors
  end

  def test_largest_palindrome_from_double_digit_factors
    # skip
    palindromes = Palindromes.new(max_factor: 99, min_factor: 10)
    palindromes.generate
    largest = palindromes.largest
    assert_equal 9009, largest.value
    assert_equal [[91, 99]], largest.factors
  end

  def test_smallest_palindrome_from_double_digit_factors
    # skip
    palindromes = Palindromes.new(max_factor: 99, min_factor: 10)
    palindromes.generate
    smallest = palindromes.smallest
    assert_equal 121, smallest.value
    assert_equal [[11, 11]], smallest.factors
  end

  def test_largest_palindrome_from_triple_digit_factors
    # skip
    palindromes = Palindromes.new(max_factor: 999, min_factor: 100)
    palindromes.generate
    largest = palindromes.largest
    assert_equal 906_609, largest.value
    assert_equal [[913, 993]], largest.factors
  end

  def test_smallest_palindrome_from_triple_digit_factors
    # skip
    palindromes = Palindromes.new(max_factor: 999, min_factor: 100)
    palindromes.generate
    smallest = palindromes.smallest
    assert_equal 10_201, smallest.value
    assert_equal [[101, 101]], smallest.factors
  end
end