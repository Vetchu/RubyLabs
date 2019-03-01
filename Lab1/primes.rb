require 'prime.rb'

def primes(*args)
  for x in args do
    tmpx = x.to_c.to_f rescue -1
    x = x.to_f rescue 1
    newx = x.to_i rescue 0
    if tmpx == x
      if newx == x
        if Prime.prime?(newx)
          puts newx
        end
      end
    end
  end
end

if ARGV.empty?
  puts "argumenty?"
else
  primes(*ARGV)
end