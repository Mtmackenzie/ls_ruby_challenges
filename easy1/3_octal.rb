# 3 Octal
# Implement octal to decimal conversion. Given an octal input string, your program should produce a decimal output.
# Input: octal input string
# Output: decimal output
# Rules: treat invalid input as octal 0 (invalid input is anything that is not the string version of an integer, or containing integers 8 and 9).
# 
# Algo: 
# check to make sure the input is valid - see if all chars are equal to themselves turned in to integer then back to string. if valid, convert to integer. if not valid, 0.
# to make decimal, convert to array of digits. iterate over array of digits (reversed as they are) and multiply times 10 to the index power. add all together.

class Octal
  def initialize(string)
    @number = validate(string)
  end

  def validate(value)
    value.chars.each do |char|
      return 0 if !(0..7).include?(char.to_i)
      return 0 if char.to_i.to_s != char
    end.join.to_i
  end
  
  def to_decimal
    sum = 0
    @number.digits.each_with_index do |n, idx|
      sum += (n * (8**idx))
    end
    sum
  end
end

require 'minitest/autorun'
# require_relative 'octal'

class OctalTest < Minitest::Test
  def test_octal_1_is_decimal_1
    assert_equal 1, Octal.new('1').to_decimal
  end

  def test_octal_10_is_decimal_8
    # skip
    assert_equal 8, Octal.new('10').to_decimal
  end

  def test_octal_17_is_decimal_15
    # skip
    assert_equal 15, Octal.new('17').to_decimal
  end

  def test_octal_11_is_decimal_9
    # skip
    assert_equal 9, Octal.new('11').to_decimal
  end

  def test_octal_130_is_decimal_88
    # skip
    assert_equal 88, Octal.new('130').to_decimal
  end

  def test_octal_2047_is_decimal_1063
    # skip
    assert_equal 1063, Octal.new('2047').to_decimal
  end

  def test_octal_7777_is_decimal_4095
    # skip
    assert_equal 4095, Octal.new('7777').to_decimal
  end

  def test_octal_1234567_is_decimal_342391
    # skip
    assert_equal 342_391, Octal.new('1234567').to_decimal
  end

  def test_invalid_octal_is_decimal_0
    # skip
    assert_equal 0, Octal.new('carrot').to_decimal
  end

  def test_8_is_seen_as_invalid_and_returns_0
    # skip
    assert_equal 0, Octal.new('8').to_decimal
  end

  def test_9_is_seen_as_invalid_and_returns_0
    # skip
    assert_equal 0, Octal.new('9').to_decimal
  end

  def test_6789_is_seen_as_invalid_and_returns_0
    # skip
    assert_equal 0, Octal.new('6789').to_decimal
  end

  def test_abc1z_is_seen_as_invalid_and_returns_0
    # skip
    assert_equal 0, Octal.new('abc1z').to_decimal
  end

  def test_valid_octal_formatted_string_011_is_decimal_9
    # skip
    assert_equal 9, Octal.new('011').to_decimal
  end

  def test_234abc_is_seen_as_invalid_and_returns_0
    # skip
    assert_equal 0, Octal.new('234abc').to_decimal
  end
end