# 3 Pig Latin
# Input: PigLatin class method ::translate with string argument
# Output: new string
# Rules: if begins with vowel, don't remove vowel (y and x count as vowels). if multiple consonants at beginning, remove all until vowel. If start with q, include u in ending. if consonants and qu, add all to end.
# Problem: split sentence into words, process, join into string again
# DS: string, array
# Algo: 
# PigLatin class method ::translate with string argument
# if begins with vowel, don't remove vowel (y and x count as vowels).
# if multiple consonants at beginning, remove all until vowel. 
# If start with q, include u in ending. if consonants and qu, add all to end.
# - permanently remove first nonvowel, x, and y letters from beginning of word, store in lv
# - check to see if last letter of lv is a q, if so, also remove first u
# - add to end of word plus 'ay'

class PigLatin
  def self.translate(phrase)
    phrase.split(' ').map do |word|
      first_letters = word.slice!(/^([^aeiouyx]+|y|x)(?![^aieou])/) # negative lookahead

      if first_letters && first_letters[-1] == 'q'
        first_letters << word.slice!('u') if word[0] == 'u'
      end

      "#{word}#{first_letters}ay"
    end.join(' ')
  end
end

require 'minitest/autorun'
# require_relative 'pig_latin'

class PigLatinTest < Minitest::Test
  def test_word_beginning_with_a
    assert_equal 'appleay', PigLatin.translate('apple')
  end

  def test_other_word_beginning_e
    # skip
    assert_equal 'earay', PigLatin.translate('ear')
  end

  def test_word_beginning_with_p
    # skip
    assert_equal 'igpay', PigLatin.translate('pig')
  end

  def test_word_beginning_with_k
    # skip
    assert_equal 'oalakay', PigLatin.translate('koala')
  end

  def test_word_beginning_with_ch
    # skip
    assert_equal 'airchay', PigLatin.translate('chair')
  end

  def test_word_beginning_with_qu
    # skip
    assert_equal 'eenquay', PigLatin.translate('queen')
  end

  def test_word_with_consonant_preceding_qu
    # skip
    assert_equal 'aresquay', PigLatin.translate('square')
  end

  def test_word_beginning_with_th
    # skip
    assert_equal 'erapythay', PigLatin.translate('therapy')
  end

  def test_word_beginning_with_thr
    # skip
    assert_equal 'ushthray', PigLatin.translate('thrush')
  end

  def test_word_beginning_with_sch
    # skip
    assert_equal 'oolschay', PigLatin.translate('school')
  end

  def test_translates_phrase
    # skip
    assert_equal 'ickquay astfay unray', PigLatin.translate('quick fast run')
  end

  def test_word_beginning_with_ye
    # skip
    assert_equal 'ellowyay', PigLatin.translate('yellow')
  end

  def test_word_beginning_with_yt
    # skip
    assert_equal 'yttriaay', PigLatin.translate('yttria')
  end

  def test_word_beginning_with_xe
    # skip
    assert_equal 'enonxay', PigLatin.translate('xenon')
  end

  def test_word_beginning_with_xr
    # skip
    assert_equal 'xrayay', PigLatin.translate('xray')
  end
end