class Attribute
  @name
  @value
  @special

  def initialize(name, value)
    @name = name
    @value = value
  end

  def setspecial(special)
    @special = special
  end

  def getspecial
    @special
  end

  def getvalue
    @value
  end

  def getname
    @name
  end
end