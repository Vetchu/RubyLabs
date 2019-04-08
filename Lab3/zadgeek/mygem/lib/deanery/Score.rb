module Grade
  NORMAL = 0
  FINAL = 1
  EXAM = 2
end

class Score
  attr_reader :type, :score
  @score
  @type

  def initialize(score, type)
    @score = score
    @type = type #from_s(type) rescue Grade::NORMAL
  end

  # def from_s(type)
  #
  #   type = type.to_s.upcase
  #   if type == "NORMAL"
  #     Grade::NORMAL
  #   else
  #     if type == "FINAL"
  #       Grade::FINAL
  #     else
  #       if type == "EXAM"
  #         Grade::EXAM
  #       else
  #         raise "incorrect type"
  #       end
  #     end
  #   end
  # end

  def get_info
    [@score, @type]
  end

  def to_s
    @score
  end

end
