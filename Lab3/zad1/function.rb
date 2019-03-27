def handleArgs(*args)
  puts args.map {|arg| File.read("./" + arg).split(/[\s \n]/).select {|word| word.to_i % 2 == 0 && word.to_i != 0}.length}.inject(:+)
end

if __FILE__ == $0
  if ARGV.empty?
    puts "argumenty?"
  else
    handleArgs(*ARGV)
  end
end
