# 4 Protein Translation
# RNA = 3 codons, all together in one string (will have to split)
# codon = 3 letters

# Input: Translation class with class methods ::of_rna and ::of_codon, both take an argument
# Output: ::of_rna - array of strings. ::of_codon - string
# Rules: raise InvalidCodonError if strand is invalid
# Problem: check to see if input is valid. ::of_codon method matches input to corresponding codon. ::of_rna will split the provided strand and pass each part to the ::of_codon method, returning an array of proteins.
# DS: strings, arrays
# Algo: 
# ::of_codon method takes a string argument. 
# - check to see if string is valid (if it matches one of the provided options). if not, raise InvalidCodonError
# - return corresponding amino acid string
# - if STOP, return "STOP" string
# ::of_rna method takes a string argument
# - pass to ::of_codon method. store return value in array if not equal to STOP and return array. return array explicitly without passing STOP to it if return value of ::of_codon is STOP.

class InvalidCodonError < StandardError; end

class Translation
  def self.amino_acid(codon)
    case codon
    when :AUG	then 'Methionine'
    when :UUU, :UUC	then 'Phenylalanine'
    when :UUA, :UUG	then 'Leucine'
    when :UCU, :UCC, :UCA, :UCG then	'Serine'
    when :UAU, :UAC	then 'Tyrosine'
    when :UGU, :UGC	then 'Cysteine'
    when :UGG	then 'Tryptophan'
    when :UAA, :UAG, :UGA	then 'STOP'
    else raise InvalidCodonError
    end
  end

  def self.of_codon(codon)
    amino_acid(codon.to_sym)
  end

  def self.of_rna(strand)
    strand = strand.clone
    protein = []
    while strand != ''
      if of_codon(strand.slice(0..2)) == 'STOP'
        return protein
      else
        protein << of_codon(strand.slice!(0..2))
      end
    end
    protein
  end
end

require 'minitest/autorun'
# require_relative 'protein_translation'

# rubocop:disable Style/MethodName
class TranslationTest < Minitest::Test
  def test_AUG_translates_to_methionine
    assert_equal 'Methionine', Translation.of_codon('AUG')
  end

  def test_identifies_Phenylalanine_codons
    # skip
    assert_equal 'Phenylalanine', Translation.of_codon('UUU')
    assert_equal 'Phenylalanine', Translation.of_codon('UUC')
  end

  def test_identifies_Leucine_codons
    # skip
    %w(UUA UUG).each do |codon|
      assert_equal 'Leucine', Translation.of_codon(codon)
    end
  end

  def test_identifies_Serine_codons
    # skip
    %w(UCU UCC UCA UCG).each do |codon|
      assert_equal 'Serine', Translation.of_codon(codon)
    end
  end

  def test_identifies_Tyrosine_codons
    # skip
    %w(UAU UAC).each do |codon|
      assert_equal 'Tyrosine', Translation.of_codon(codon)
    end
  end

  def test_identifies_Cysteine_codons
    # skip
    %w(UGU UGC).each do |codon|
      assert_equal 'Cysteine', Translation.of_codon(codon)
    end
  end
  def test_identifies_Tryptophan_codons
    # skip
    assert_equal 'Tryptophan', Translation.of_codon('UGG')
  end

  def test_identifies_stop_codons
    # skip
    %w(UAA UAG UGA).each do |codon|
      assert_equal 'STOP', Translation.of_codon(codon)
    end
  end

  def test_translates_rna_strand_into_correct_protein
    # skip
    strand = 'AUGUUUUGG'
    expected = %w(Methionine Phenylalanine Tryptophan)
    assert_equal expected, Translation.of_rna(strand)
  end

  def test_stops_translation_if_stop_codon_present
    # skip
    strand = 'AUGUUUUAA'
    expected = %w(Methionine Phenylalanine)
    assert_equal expected, Translation.of_rna(strand)
  end

  def test_stops_translation_of_longer_strand
    # skip
    strand = 'UGGUGUUAUUAAUGGUUU'
    expected = %w(Tryptophan Cysteine Tyrosine)
    assert_equal expected, Translation.of_rna(strand)
  end

  def test_invalid_codons
    # skip
    strand = 'CARROT'
    assert_raises(InvalidCodonError) do
      Translation.of_rna(strand)
    end
  end
end