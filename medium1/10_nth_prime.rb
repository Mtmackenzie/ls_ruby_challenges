# 10 Nth Prime
=begin
Input: n integer
Output: integer (prime number)
Rules: don't use Prime. Argument error if weird input like 0.
Problem: collect prime numbers in an array and return the last one once the size is equal to n?
to find prime number, can only be divisible by 1 and itself. so can iterate over array of prime numbers to see if it's divisible by anything in the array up to the square root of that number.
Algo: 
Prime class, class method nth that takes one argument, an integer. raise error if argument is invalid.
iterate over nums from 1 to however long it takes. given num
start with 2 in array. iterate over primes array and check to see if given number modulo num is not equal to zero. if all numbers check out, add to array. (sqrt trick?)
break out of loop if the array's size is equal to n
=end
class FindLastPrime
  def initialize
    @primes = [2]
  end

  def find_nth(n)
    3.upto(Float::INFINITY) do |current_num|
      return last_prime if @primes.size == n
      @primes << current_num if is_prime?(current_num)
    end
  end

  def last_prime
    @primes.last
  end

  def is_prime?(number)
    @primes.all? do |prime|
      return true if prime > Math.sqrt(number)
      number % prime != 0
    end
  end
end

class Prime
  def self.nth(n)
    raise ArgumentError if n < 1
    FindLastPrime.new.find_nth(n)
  end
end


require 'prime'

ERROR_MESSAGE = <<-MSG.freeze
Using Ruby's Prime class is probably the best way to do this in a
'real' application; but this is an exercise, not a real application,
so you're expected to implement this yourself.
MSG

# This code prevents you from using any of the prohibited methods.

class Prime
  [:each, :new, :prime?, :take].each do |m|
    define_method(m) { |*_| fail ERROR_MESSAGE }
  end
end

class Integer
  [:prime?, :each_prime].each do |m|
    define_method(m) { |*_| fail ERROR_MESSAGE }
  end
end

# Actual test suite begins here.

require 'minitest/autorun'
# require_relative 'nth_prime'

class TestPrimes < Minitest::Test
  def test_first
    assert_equal 2, Prime.nth(1)
  end

  def test_second
    # skip
    assert_equal 3, Prime.nth(2)
  end

  def test_sixth_prime
    # skip
    assert_equal 13, Prime.nth(6)
  end

  def test_big_prime
    # skip
    assert_equal 104_743, Prime.nth(10_001)
  end

  def test_weird_case
    # skip
    assert_raises ArgumentError do
      Prime.nth(0)
    end
  end
end