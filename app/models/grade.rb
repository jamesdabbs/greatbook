class Grade
  SCORES = {
    'A' => 4.0,
    'A-' => 3.7,
    'B+' => 3.3,
    'B' => 3.0,
    'B-' => 2.7,
    'C+' => 2.3,
    'C' => 2.0,
    'C-' => 1.7,
    'D' => 1.0,
    'F' => 0.0
  }

  include Comparable

  attr_reader :value

  def initialize(value)
    @value = value
  end

  def to_s
    value
  end

  def <=>(other)
    score <=> other.score
  end

  def score
    SCORES.fetch(value)
  end
end
