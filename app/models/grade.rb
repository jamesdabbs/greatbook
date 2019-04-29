class Grade
  SCORES = {
    'A' => 4.0,
    'B' => 3.0,
    'C' => 2.0,
    'D' => 1.0,
    'F' => 0.0
  }

  class << self
    def for(value)
      return value if value.is_a?(Grade)

      all.find { |grade| grade.name == value } || raise(ArgumentError, "#{value} is not a valid grade")
    end

    def all
      @all ||= SCORES.map do |letter, score|
        new(letter, score)
      end
    end

    def load(value)
      return unless value

      Grade.for(value)
    end

    def dump(value)
      return unless value

      Grade.for(value).name
    end

    protected :new
  end

  attr_reader :name, :score

  def initialize(name, score)
    @name = name
    @score = score
  end

  include Comparable

  def <=>(other)
    score <=> Grade.for(other).score
  rescue ArgumentError
  end

  def at_least?(other)
    self >= other
  end

  def as_json(*)
    name
  end
end