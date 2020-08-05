# 6 Grade School
=begin
Rules: students only have one name. sort hash by keys first, then values.
Problem: 1. how to add a key/value pair to a hash and check if key is already present or not.
2. how to sort by keys, then by values.
DS: hash
keys: grade, values: array of strings with names.
Algo: 
School object, initialized without arguments. constructor contains an empty hash.
to_h returns a hash object (initially empty). sorts the hash object by keys, then by values.
#add instance method: input: name string object, grade. grade becomes key, name is added to an array of string objects as value.
- when adding new students, need to check if the grade is already present in the keys. otherwise, just push the new string object to the value array.
#grade instance method that accepts an integer as an argument will return an array of students in that grade (sorted). returns empty array if argument is not present in keys.
=end

class School
  def initialize
    @roster = {}
  end

  def to_h
    @roster.sort.to_h
  end

  def add(name, grade)
    if @roster.keys.include?(grade)
      @roster[grade] << name
      @roster[grade].sort!
    else
      @roster[grade] = [name]
    end
  end

  def grade(number)
    @roster.keys.include?(number) ? @roster[number] : []
  end
end

require 'minitest/autorun'
# require_relative 'grade_school'

class SchoolTest < Minitest::Test
  attr_reader :school

  def setup
    @school = School.new
  end

  def test_an_empty_school
    assert_equal({}, school.to_h)
  end

  def test_add_student
    # skip
    school.add('Aimee', 2)
    assert_equal({ 2 => ['Aimee'] }, school.to_h)
  end

  def test_add_more_students_in_same_class
    # skip
    school.add('Blair', 2)
    school.add('James', 2)
    school.add('Paul', 2)
    assert_equal({ 2 => %w(Blair James Paul) }, school.to_h)
  end

  def test_add_students_to_different_grades
    # skip
    school.add('Chelsea', 3)
    school.add('Logan', 7)
    assert_equal({ 3 => ['Chelsea'], 7 => ['Logan'] }, school.to_h)
  end

  def test_get_students_in_a_grade
    # skip
    school.add('Bradley', 5)
    school.add('Franklin', 5)
    school.add('Jeff', 1)
    assert_equal %w(Bradley Franklin), school.grade(5)
  end

  def test_get_students_in_a_non_existant_grade
    # skip
    assert_equal [], school.grade(1)
  end

  def test_sort_school # rubocop:disable Metrics/MethodLength
    # skip
    [
      ['Jennifer', 4], ['Kareem', 6],
      ['Christopher', 4], ['Kyle', 3]
    ].each do |name, grade|
      school.add(name, grade)
    end
    sorted = {
      3 => ['Kyle'],
      4 => %w(Christopher Jennifer),
      6 => ['Kareem']
    }
    assert_equal sorted, school.to_h
    assert_equal [3, 4, 6], school.to_h.keys
  end
end