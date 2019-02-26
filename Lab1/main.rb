# Calculates 'arg1' + 'arg2'.
#
# @param arg1 [Integer, Float, String, Rational, Complex]
#        the first component of the sum
# @param arg2 [Integer, Float, String, Rational, Complex]
#        the second component of the sum
# @return [Integer, Float, Rational, Complex]
#         sum of two numbers
def sum(arg1, arg2)
  arg1=Integer(arg1);
  arg2=Integer(arg2)
  var=arg1+arg2;
  return var;
end

if __FILE__ == $0
  puts "suma = #{sum(1,2)}"
end
