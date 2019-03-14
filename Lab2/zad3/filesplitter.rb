def handleArgs(*args)
  filename = args[0].to_s
  if File.exist?('./' + filename) && !File.zero?('./' + filename)
    lines = File.readlines('./' + filename).reject(&:empty?)
    lines.map do |line|
      line.split.first
    end
    for line in lines
      words = line.split(" ")
      words.each(&method(:puts))
    end
  end

end

if __FILE__ == $0
  if ARGV.empty?
    puts "argumenty?"
  else
    handleArgs(*ARGV)
  end
end
