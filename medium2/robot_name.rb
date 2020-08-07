class Robot
  attr_reader :name

  @@existing_names = []

  def initialize
    @name = generate
  end

  def reset
    @@existing_names.delete(@name)
    @name = generate
  end

  private

  LETTERS = ('A'..'Z').to_a
  NUMBERS = ('1'..'9').to_a

  def generate
    loop do
      @name = ''
      2.times { @name << LETTERS.sample }
      3.times { @name << NUMBERS.sample }
      break if !@@existing_names.include?(@name)
    end
    @@existing_names << @name
    @name
  end
end
