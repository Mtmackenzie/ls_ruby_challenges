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

  def remove_front_letters(arr, text, word_size)
    arr.push(text.slice!(0..(word_size - 1)))
  end

  def calculate_word_size
    (normalize_plaintext.size.to_f / size).ceil
  end

  def calculate_number_of_lines(word_size)
    (normalize_plaintext.size.to_f / word_size).ceil
  end

  def create_words_array
    arr = []
    text = ciphertext
    word_size = calculate_word_size
    number_of_lines = calculate_number_of_lines(word_size)

    number_of_lines.downto(1) do |line|
      word_size = text.size / line if text.size % line == 0
      line == 1 ? arr.push(text) : remove_front_letters(arr, text, word_size)
    end

    arr
  end

  def normalize_ciphertext
    create_words_array.join(' ')
  end
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
      'If man was meant to stay on the ground god would have given us roots'
    )
    expected = 'imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn sseoau'
    assert_equal expected, crypto.normalize_ciphertext
  end

  def test_normalized_ciphertext_with_punctuation
    # skip
    crypto = Crypto.new('Have a nice day. Feed the dog & chill out!')
    expected = 'hifei acedl veeol eddgo aatcu nyhht'
    assert_equal expected, crypto.normalize_ciphertext
  end

  def test_normalized_ciphertext_when_just_less_then_a_full_square
    # skip
    crypto = Crypto.new('I am')
    assert_equal 'im a', crypto.normalize_ciphertext
  end
end
