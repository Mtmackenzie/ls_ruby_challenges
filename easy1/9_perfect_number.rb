# 9 Perfect Number
# Write a program that can tell if a number is perfect, abundant or deficient.
# Input: integer
# Output: string: "perfect", "abundant", "deficient"
# Rules: raise StandardError if number is not positive integer
# Problem: 1. see if num is valid. 2. make list of divisors (not including num itself). 3. return string depending on sum of divisors).
# Algo: 
# PerfectNumber class with classify class method
# - check to see if given num is greater than 0. if not, raise StandardError
# - sum lv, = 0
#  - iterate over num % divisor starting with divisor as num and going down to 2. if remainder is 0, add num / divisor to sum lv.
#  - case statement? or figure out which string to return based on sum

class PerfectNumber
  def self.classify(num)
    raise StandardError unless num > 0
    @@num = num
    sum = divisor_sum
    if sum == @@num
      "perfect"
    elsif sum > @@num
      "abundant"
    else
      "deficient"
    end
  end

  def self.divisor_sum
    sum = 0
    @@num.downto(2) do |divisor|
      sum += (@@num / divisor) if @@num % divisor == 0
    end
    sum
  end
end

require 'minitest/autorun'
# require_relative 'perfect_numbers'

class PerfectNumberTest < Minitest::Test
  def test_initialize_perfect_number
    assert_raises StandardError do
      PerfectNumber.classify(-1)
    end
  end

  def test_classify_deficient
    assert_equal 'deficient', PerfectNumber.classify(13)
  end

  def test_classify_perfect
    assert_equal 'perfect', PerfectNumber.classify(28)
  end

  def test_classify_abundant
    assert_equal 'abundant', PerfectNumber.classify(12)
  end
end