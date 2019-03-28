require 'getoptlong'

class Calculator
  def parsenum x
    tmpx = x.to_c.to_f rescue -1
    x = x.to_f rescue 1
    newx = x.to_i rescue 0
    if tmpx == x && x == newx
      return x
    end
    raise ArgumentError
  end

  def add(num1, num2)
    num1 = Integer num1 rescue raise ArgumentError
    num2 = Integer num2 rescue raise ArgumentError
    num1 + num2
  end

  def multiply(num1, num2)
    num1 = Integer num1 rescue raise ArgumentError
    num2 = Integer num2 rescue raise ArgumentError
    num1 * num2
  end

  def divide(num1, num2)
    num1 = Integer num1 rescue raise ArgumentError
    num2 = Integer num2 rescue raise ArgumentError
    num1 / num2
  end
end

class WordOperator
  def swap(string)
    if string.to_i != 0
      raise ArgumentError
    end
    string = string.split(" ")[0]
    string.swapcase
  end

  def reverse(string)
    if string.to_i != 0
      raise ArgumentError
    end
    string = string.split(" ")[0]
    string.reverse!
  end
end

opts = GetoptLong.new(
    ['--divide', '-d', GetoptLong::REQUIRED_ARGUMENT],
    ['--add', '-a', GetoptLong::REQUIRED_ARGUMENT],
    ['--multiply', '-m', GetoptLong::REQUIRED_ARGUMENT],
    ['--reverse', '-r', GetoptLong::REQUIRED_ARGUMENT],
    ['--swapcase', '-s', GetoptLong::REQUIRED_ARGUMENT],
)

opts.each do |opt, arg|
  case opt
  when '--divide'
    puts Calculator.new.divide(arg.split(",")[0], arg.split(",")[1])
  when '--add'
    puts Calculator.new.add(arg.split(",")[0], arg.split(",")[1])
  when '--multiply'
    puts Calculator.new.multiply(arg.split(",")[0], arg.split(",")[1])
  when '--reverse'
    puts WordOperator.new.reverse(arg.split(" ")[0])
  when '--swapcase'
    puts WordOperator.new.swap(arg.split(" ")[0])
  else
    "wrong arguments given"
  end
end