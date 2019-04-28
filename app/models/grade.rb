class Grade
  SCORES = {
    'A' => 4.0,
    'B' => 3.0,
    'C' => 2.0,
    'D' => 1.0,
    'F' => 0.0
  }

  def self.all
    @all ||= SCORES.map do |letter, value|
      new(letter, value)
    end
  end

  def self.for(value)
    return value if value.is_a?(Grade)

    all.find { |grade| grade.name == value } || raise(ArgumentError, "Invalid grade: #{value}")
  end

  def self.load(string)
    return unless string

    self.for(string)
  end

  def self.dump(value)
    return unless value

    Grade.for(value).name
  end

  class << self
    protected :new
  end

  attr_reader :name, :score

  def initialize(name, score=nil)
    @name  = name
    @score = score
  end

  include Comparable
  def <=>(other)
    score <=> Grade.for(other).score
  rescue ArgumentError
    -1
  end

  def at_least?(other)
    self >= Grade.for(other)
  end

  def as_json(*)
    name
  end
end