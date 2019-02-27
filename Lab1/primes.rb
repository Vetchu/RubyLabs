require 'prime.rb'
def primes(*args)
  for x in args do
    x=Integer(x) rescue 0
    if Prime.prime?(x)
      puts x
    end
  end
end

if ARGV.empty?
  puts "argumenty?"
else
  primes(*ARGV)
end