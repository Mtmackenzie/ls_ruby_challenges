# 10 Roman Numerals
# Input: integer
# Output: roman numeral string object
# Rules: don't go over 3000. 
# Problem: define new integer instance method, #to_roman. break apart into array of digits and based on place assign letters. add new letters to string. USE MATRIX.

#          0  1  2
# index 0: I, V, X
# index 1: X, L, C
# index 2: C, D, M
# index 3: M

# for each number, make into array of digits (reversed from original). iterate over array of digits using the index. using the numeral matrix, use pattern below and prepend to lv string container.
# MCMXC   (prepend each one to front)
# if num is 0, next
# if num is between 1-3 inclusive, rom[0] * n
# if num is 4, rom[0] + rom[1]
# if num is 5, rom[1]
# if num is 6-8, rom[1] + rom[0] * (n - 5)
# if num is 9, rom[0] + rom[2]

class Integer
  ROMAN = [['I', 'V', 'X'], ['X', 'L', 'C'], ['C', 'D', 'M'],['M']]

  def to_roman
    result = ''
    self.digits.each_with_index do |n, index|
      case n
      when 0
        next
      when 1..3
        result.prepend(ROMAN[index][0] * n)
      when 4
        result.prepend(ROMAN[index][0] + ROMAN[index][1])
      when 5
        result.prepend(ROMAN[index][1])
      when 6..8
        result.prepend(ROMAN[index][1] + (ROMAN[index][0] * (n - 5)))
      when 9
        result.prepend(ROMAN[index][0] + ROMAN[index][2])
      end
    end
    result
  end
end

require 'minitest/autorun'
# require_relative 'roman_numerals'

class RomanNumeralsTest < Minitest::Test
  def test_1
    assert_equal 'I', 1.to_roman
  end

  def test_2
    # skip
    assert_equal 'II', 2.to_roman
  end

  def test_3
    # skip
    assert_equal 'III', 3.to_roman
  end

  def test_4
    # skip
    assert_equal 'IV', 4.to_roman
  end

  def test_5
    # skip
    assert_equal 'V', 5.to_roman
  end

  def test_6
    # skip
    assert_equal 'VI', 6.to_roman
  end

  def test_9
    # skip
    assert_equal 'IX', 9.to_roman
  end

  def test_27
    # skip
    assert_equal 'XXVII', 27.to_roman
  end

  def test_48
    # skip
    assert_equal 'XLVIII', 48.to_roman
  end

  def test_59
    # skip
    assert_equal 'LIX', 59.to_roman
  end

  def test_93
    # skip
    assert_equal 'XCIII', 93.to_roman
  end

  def test_141
    # skip
    assert_equal 'CXLI', 141.to_roman
  end

  def test_163
    # skip
    assert_equal 'CLXIII', 163.to_roman
  end

  def test_402
    # skip
    assert_equal 'CDII', 402.to_roman
  end

  def test_575
    # skip
    assert_equal 'DLXXV', 575.to_roman
  end

  def test_911
    # skip
    assert_equal 'CMXI', 911.to_roman
  end

  def test_1024
    # skip
    assert_equal 'MXXIV', 1024.to_roman
  end

  def test_3000
    # skip
    assert_equal 'MMM', 3000.to_roman
  end
end