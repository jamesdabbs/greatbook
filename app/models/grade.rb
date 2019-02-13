class Grade
  include Comparable

  attr_reader :value

  def initialize(value)
    @value = value
  end

  def to_s
    value
  end

  def <=>(other)
    other.value <=> value
  end
end
