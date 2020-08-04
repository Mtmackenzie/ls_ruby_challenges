# 2 Luhn Algorithm
# Input: number
# Output: addends: array of digits, checksum: integer, valid? boolean, create: integer (valid) 
# Rules: 
# Problem: 
# starting from rightmost digits, double every second digit. subtract 9 if greater than 10. find sum of all digits. if total modulo 10 is equal to 0, num is valid.
# Algo: 
# Luhn instances instantiated with number.
# addends instance method returns array
# - take number instance variable and split into array of digits. iterate over array by index and for odd indices double digit. if the digit is greater than 10, subtract 9 from digit. return reversed array. 
# checksum: integer
# - addends
# - find sum of addends.
# valid? boolean
# - see if checksum modulo 10 is equal to zero
# create: integer (valid)
# class method that returns an integer
# - instantiate a new Luhn instance, check if valid, if not:
# - find next highest num that ends in 0 (modulo 10 equal to zero) and find difference OR add 1 to sum until modulo 10 is equal to zero and add that num to end of addends

class Luhn
  def initialize(number)
    @number = number
  end

  def addends
    @addends = @number.digits.map.with_index do |digit, index|
      if index.odd?
        digit * 2 > 9 ? ((digit*2) - 9) : (digit * 2)
      else
        digit
      end
    end.reverse
  end

  def checksum
    addends.sum
  end

  def valid?
    checksum % 10 == 0
  end

  def <<(value)
    @number = @number.digits.prepend(value).reverse.join.to_i
  end

  def slice!
    @number = @number.to_s
    @number.slice!(-1)
    @number = @number.to_i
  end

  def self.create(number)
    new_number = Luhn.new(number)
    (0..9).each do |num|
      new_number << num
      return new_number.number if new_number.valid?
      new_number.slice!
    end
    new_number.number
  end

  attr_reader :number
end

require 'minitest/autorun'
# require_relative 'luhn'

class LuhnTest < Minitest::Test
  def test_addends
    luhn = Luhn.new(12_121)
    assert_equal [1, 4, 1, 4, 1], luhn.addends
  end

  def test_too_large_addend
    # skip
    luhn = Luhn.new(8631)
    assert_equal [7, 6, 6, 1], luhn.addends
  end

  def test_checksum
    # skip
    luhn = Luhn.new(4913)
    assert_equal 22, luhn.checksum
  end

  def test_checksum_again
    # skip
    luhn = Luhn.new(201_773)
    assert_equal 21, luhn.checksum
  end

  def test_invalid_number
    # skip
    luhn = Luhn.new(738)
    refute luhn.valid?
  end

  def test_valid_number
    # skip
    luhn = Luhn.new(8_739_567)
    assert luhn.valid?
  end

  def test_create_valid_number
    # skip
    number = Luhn.create(123)
    assert_equal 1230, number
  end

  def test_create_other_valid_number
    # skip
    number = Luhn.create(873_956)
    assert_equal 8_739_567, number
  end

  def test_create_yet_another_valid_number
    # skip
    number = Luhn.create(837_263_756)
    assert_equal 8_372_637_564, number
  end
end