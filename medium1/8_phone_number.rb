# 8 Phone Number
=begin
Input: string
Output: string
Rules: given number can contain parentheses, hyphen, space, period. invalid if: contains letters, contains more or less digits. could start with one, but none of the instance methods take this extra valid 1 into account, so probably could delete.
Problem: 
remove any nondigit characters
check size: less than 10 digits, 11 or higher without 1 as first num.  if not valid, string of 10 0's
remove first one if 11 digits so @number contains only 10 digits.
area_code call on number and return first three digits as a string.
to_s special formatting.
DS: strings
Algo: PhoneNumber class that accepts string in constructor. number getter method formats the given string. area code method. to_s method special format (parenthesis and hyphen)
=end

class PhoneNumber
  attr_reader :number
  def initialize(number)
    @number = validate_number(number)
  end

  def validate_number(number)
    invalid = '0000000000'
    return invalid if number.match(/[a-z]/i)
    number = number.scan(/\d/).join
    if (number.size == 11) && (number[0] == '1')
      number.slice(1..10)
    elsif number.size == 10
      number
    else  
      invalid
    end
  end

  def area_code
    number[0..2]
  end

  def to_s
    "(#{area_code}) #{number[3..5]}-#{number[6..9]}"
  end
end

require 'minitest/autorun'
# require_relative 'phone_number'

class PhoneNumberTest < Minitest::Test
  def test_cleans_number
    number = PhoneNumber.new('(123) 456-7890').number
    assert_equal '1234567890', number
  end

  def test_cleans_a_different_number
    # skip
    number = PhoneNumber.new('(987) 654-3210').number
    assert_equal '9876543210', number
  end

  def test_cleans_number_with_dots
    # skip
    number = PhoneNumber.new('456.123.7890').number
    assert_equal '4561237890', number
  end

  def test_invalid_with_letters_in_place_of_numbers
    # skip
    number = PhoneNumber.new('123-abc-1234').number
    assert_equal '0000000000', number
  end

  def test_invalid_when_9_digits
    # skip
    number = PhoneNumber.new('123456789').number
    assert_equal '0000000000', number
  end

  def test_valid_when_11_digits_and_first_is_1
    # skip
    number = PhoneNumber.new('19876543210').number
    assert_equal '9876543210', number
  end

  def test_valid_when_10_digits_and_area_code_starts_with_1
    # skip
    number = PhoneNumber.new('1234567890').number
    assert_equal '1234567890', number
  end

  def test_invalid_when_11_digits
    # skip
    number = PhoneNumber.new('21234567890').number
    assert_equal '0000000000', number
  end

  def test_invalid_when_12_digits_and_first_is_1
    # skip
    number = PhoneNumber.new('112345678901').number
    assert_equal '0000000000', number
  end

  def test_invalid_when_10_digits_with_extra_letters
    # skip
    number = PhoneNumber.new('1a2a3a4a5a6a7a8a9a0a').number
    assert_equal '0000000000', number
  end

  def test_area_code
    # skip
    number = PhoneNumber.new('1234567890')
    assert_equal '123', number.area_code
  end

  def test_different_area_code
    # skip
    number = PhoneNumber.new('9876543210')
    assert_equal '987', number.area_code
  end

  def test_pretty_print
    # skip
    number = PhoneNumber.new('5551234567')
    assert_equal '(555) 123-4567', number.to_s
  end

  def test_pretty_print_with_full_us_phone_number
    # skip
    number = PhoneNumber.new('11234567890')
    assert_equal '(123) 456-7890', number.to_s
  end
end