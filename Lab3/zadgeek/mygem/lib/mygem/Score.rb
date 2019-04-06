module Grade
  NORMAL = 0
  FINISH = 1
  EXAM = 2
end

class Score
  attr_reader :type, :score
  @score
  @type

  def initialize(score, type)
    @score = Grade(score)
    @type = type
  end

  def to_s
    @score
  end
end

