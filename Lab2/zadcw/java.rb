#zalozenia: ladujemy klase, ma wypisac metody, zmienne i co przypisane, a w przypadku komentarza nie wypisywac
# /home/vetch/Workspace/Ruby/RubyLabs/Lab
# 1
def javaparser
  # puts "\t\tJava parser"
  # puts '-' * 60

  dir = ARGV[0]
  data = File.read(dir)
  flag = false # flag means we are inside {} brackets
  classflag = false
  comment = false

  data.each_line do |line|
    if line =~ /.*\/\*/
      comment = true
      next
    elsif line =~ /.*\*\//
      comment = false
      next
    end

    unless comment
      if line =~ /{/ && !classflag
        puts line.gsub(/{/, '')
        classflag = true
      elsif line =~ /{/ && classflag && !flag
        puts line.gsub(/{/, '')
        flag = true
      elsif line =~ /}/ && classflag && flag
        flag = false
        next
      elsif line =~ /}/ && classflag && !flag
        classflag = false
        next
      elsif line =~ /.+ .+/ && classflag && !flag
        puts line
      elsif line =~ /}/ && flag
        flag = false
        next

      elsif line =~ /}/ && !flag
        puts line.gsub(/}/, '')
      else
        next
      end
    end
  end
end

if $PROGRAM_NAME == __FILE__
  javaparser
end