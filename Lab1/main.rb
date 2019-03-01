# Calculates 'arg1' + 'arg2'.
#
# @param arg1 [Integer, Float, String, Rational, Complex]
#        the first component of the sum
# @param arg2 [Integer, Float, String, Rational, Complex]
#        the second component of the sum
# @return [Integer, Float, Rational, Complex]
#         sum of two numbers
def sum(arg1, arg2)
  arg1 = convert_string_number(arg1)
  arg2 = convert_string_number(arg2)
  var = arg1 + arg2;
  return var;
end

def cant_convert
  warn("\e[4m#{__FILE__}:#{__LINE__}\e[0m: \e[31mArgument funkcji 'sum()' nie jest ani liczbą, ani napisem\e[0m");
end

def convert_string_number(arg)
  arg=arg.to_s
  [:Integer, :Float, :Rational, :Complex].each do |m|
    begin
      return send(m, arg)
    rescue ArgumentError
    end
  end
  raise TypeError
end


if __FILE__ == $0
  puts "suma = #{sum(2, '3')}"
end
