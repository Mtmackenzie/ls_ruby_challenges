# 1 Secret Handshake
# Input: decimal number
# Output: array of strings
# Rules: if invalid binary string or 0, return empty array.
# Algo: 
# SecretHandshake, new objects instantiated with decimal integer or string binary stored in iv - figure out which one it is, instance method: commands returns array of strings
# 11111 - iterate over numbers in binary nums string (reversed). if current number is one, then add command that corresponds to same index of ACTIONS array to @commands array.
# 1 = wink
# 10 = double blink
# 100 = close your eyes
# 1000 = jump
# 10000 = Reverse the order of the operations in the secret handshake.

class SecretHandshake
  ACTIONS = ['wink', 'double blink', 'close your eyes', 'jump']

  def initialize(number)
    @number = format_input(number)
    @commands = []
  end

  def commands
    analyze_number
    @commands
  end

  private

  def format_input(number)
    if number.is_a?(String)
      number.to_i.to_s == number ? number : nil
    else
      number.to_s(2)
    end
  end

  def analyze_number
    return nil if @number == nil
    number = @number.reverse.chars
    number.each_with_index do |num, idx|
      if idx == 4
        @commands.reverse!
      elsif num == '1'
        @commands << ACTIONS[idx]
      end
    end
  end
end

require 'minitest/autorun'
# require_relative 'secret_handshake'

class SecretHandshakeTest < Minitest::Test
  def test_handshake_1_to_wink
    handshake = SecretHandshake.new(1)
    assert_equal ['wink'], handshake.commands
  end

  def test_handshake_10_to_double_blink
    # skip
    handshake = SecretHandshake.new(2)
    assert_equal ['double blink'], handshake.commands
  end

  def test_handshake_100_to_close_your_eyes
    # skip
    handshake = SecretHandshake.new(4)
    assert_equal ['close your eyes'], handshake.commands
  end

  def test_handshake_1000_to_jump
    # skip
    handshake = SecretHandshake.new(8)
    assert_equal ['jump'], handshake.commands
  end

  def test_handshake_11_to_wink_and_double_blink
    # skip
    handshake = SecretHandshake.new(3)
    assert_equal ['wink', 'double blink'], handshake.commands
  end

  def test_handshake_10011_to_double_blink_and_wink
    # skip
    handshake = SecretHandshake.new(19)
    assert_equal ['double blink', 'wink'], handshake.commands
  end

  def test_handshake_11111_to_double_blink_and_wink
    # skip
    handshake = SecretHandshake.new(31)
    expected = ['jump', 'close your eyes', 'double blink', 'wink']
    assert_equal expected, handshake.commands
  end

  def test_valid_string_input
    # skip
    handshake = SecretHandshake.new('1')
    assert_equal ['wink'], handshake.commands
  end

  def test_invalid_handshake
    # skip
    handshake = SecretHandshake.new('piggies')
    assert_equal [], handshake.commands
  end
end