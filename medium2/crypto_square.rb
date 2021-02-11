=begin
Input: string
Output: encoded string
Rules: find size of square based on amount of characters. only downcased alphanumeric letters.
Problem: remove all nonalphanumeric characters. find "row size" and either make sections of letters based on row size or iterate over the row and every "row size" character add to new string to add to array, stopping when hit the end. based on index.
row size: find square root of the total length and round up.
Algo: 
Crypto class that has one class variable, string
normalize_plaintext method called on object
size method called on object
plaintext_segments that breaks string apart into x-sized segments (returns array)
ciphertext method finds new string without spaces
normalize_ciphertext adds spaces, dynamically checking after each space what the remaining size is, and if it's divisible evenly by the remaining number of characters, change the length of the line to match the size / remaining number of lines
=end

class Crypto
  def initialize(string)
    @string = string
  end

  def normalize_plaintext
    @string.downcase.scan(/[a-z0-9]/).join
  end

  def size
    Math.sqrt(normalize_plaintext.size).ceil
  end

  def plaintext_segments
    array = normalize_plaintext.chars
    segments = []
    counter = 0
    loop do
      break if array.empty?
      string = ''
      while counter < size
        string << array.shift
        counter += 1
        break if array.empty?
      end
      segments << string
      string = ''
      counter = 0
    end
    segments
  end

  def ciphertext
    @new_words = []
    index = 0
    loop do
      break if index == size
      string = ''
      plaintext_segments.each do |word|
        string << word[index] if word[index]
      end
      @new_words << string
      string = ''
      index += 1
    end
    @new_words.join
  end

  def normalize_ciphertext
    word_size = (normalize_plaintext.size / size).ceil
    number_of_lines = (normalize_plaintext.size / word_size).ceil
    # iterate over numbers from number_of_lines down to 1 (returns first integer)
    # for first element, add to results array word_size amount of characters sliced off front of old_text plus a space
    # in next and further iterations, check at each point to see if the size of the remaining characters in old_text is evenly divisible by the current integer
      # if so, change word size to that new divisor
      # slice off word size and again add to results
    # if the number is 1, add rest of letters to results
    # join results array
    results = []
    old_text = ciphertext
    number_of_lines.downto(1) do |line|
      if line == 1
        results.push(old_text)
      elsif line > 1
        word_size = old_text/number_of_lines if old_text % number_of_lines == 0
        results.push(old_text.slice!(0..(word_size - 1)))
      end
    end
        
    results.join(' ')
  end

    # new_text = ''
    # old_text = ciphertext
    # old_text.chars.each.with_index do |_, idx|
    #   if old_text
    #     if (idx+1) % word_size == 0 && idx != ciphertext.size - 1
    #       new_text << old_text.slice!(0) + ' '
    #     else
    #       new_text << old_text.slice!(0)
    #     end
    #   # else
    #   end

end

require 'minitest/autorun'
# require_relative 'crypto_square'

class CryptoTest < Minitest::Test
  def test_normalize_strange_characters
    crypto = Crypto.new('s#$%^&plunk')
    assert_equal 'splunk', crypto.normalize_plaintext
  end

  def test_normalize_uppercase_characters
    # skip
    crypto = Crypto.new('WHOA HEY!')
    assert_equal 'whoahey', crypto.normalize_plaintext
  end

  def test_normalize_with_numbers
    # skip
    crypto = Crypto.new('1, 2, 3 GO!')
    assert_equal '123go', crypto.normalize_plaintext
  end

  def test_size_of_small_square
    # skip
    crypto = Crypto.new('1234')
    assert_equal 2, crypto.size
  end

  def test_size_of_slightly_larger_square
    # skip
    crypto = Crypto.new('123456789')
    assert_equal 3, crypto.size
  end

  def test_size_of_non_perfect_square
    # skip
    crypto = Crypto.new('123456789abc')
    assert_equal 4, crypto.size
  end

  def test_size_is_determined_by_normalized_plaintext
    # skip
    crypto = Crypto.new('Oh hey, this is nuts!')
    assert_equal 4, crypto.size
  end

  def test_plaintext_segments
    # skip
    crypto = Crypto.new('Never vex thine heart with idle woes')
    expected = %w(neverv exthin eheart withid lewoes)
    assert_equal expected, crypto.plaintext_segments
  end

  def test_other_plaintext_segments
    # skip
    crypto = Crypto.new('ZOMG! ZOMBIES!!!')
    assert_equal %w(zomg zomb ies), crypto.plaintext_segments
  end

  def test_ciphertext
    # skip
    crypto = Crypto.new('Time is an illusion. Lunchtime doubly so.')
    assert_equal 'tasneyinicdsmiohooelntuillibsuuml', crypto.ciphertext
  end

  def test_another_ciphertext
    # skip
    crypto = Crypto.new('We all know interspecies romance is weird.')
    assert_equal 'wneiaweoreneawssciliprerlneoidktcms', crypto.ciphertext
  end

  def test_normalized_ciphertext
    # skip
    crypto = Crypto.new('Vampires are people too!')
    assert_equal 'vrel aepe mset paoo irpo', crypto.normalize_ciphertext
  end

  def test_normalized_ciphertext_spills_into_short_segment
    # skip
    crypto = Crypto.new('Madness, and then illumination.')
    expected = 'msemo aanin dnin ndla etlt shui'
    assert_equal expected, crypto.normalize_ciphertext
  end

  def test_another_normalized_ciphertext
    # skip
    crypto = Crypto.new(
      'If man was meant to stay on the ground god would have given us roots',
    )
    expected = 'imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn sseoau'
    assert_equal expected, crypto.normalize_ciphertext
  end

  def test_normalized_ciphertext_with_punctuation
    skip
    crypto = Crypto.new('Have a nice day. Feed the dog & chill out!')
    expected = 'hifei acedl veeol eddgo aatcu nyhht'
    assert_equal expected, crypto.normalize_ciphertext
  end

  def test_normalized_ciphertext_when_just_less_then_a_full_square
    skip
    crypto = Crypto.new('I am')
    assert_equal 'im a', crypto.normalize_ciphertext
  end
end