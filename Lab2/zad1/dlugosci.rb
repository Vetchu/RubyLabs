require '/home/vetch/.gem/ruby/2.6.0/gems/rdoc-6.1.1/lib/rdoc.rb'
require '/home/vetch/.gem/ruby/2.6.0/gems/ansi-1.5.0/lib/ansi.rb'
class Dlugosci
  def self.count_occurencies(hash, allwords)
    namearr = allwords.split(" ")
    for word in namearr
      size = word.length
      if hash.key? size
        hash[size] += 1
      else
        hash[size] = 1
      end
    end
    hash
  end

  def self.printdb(hash)
    puts "dlugosc\tilosc"
    for key in hash.keys
      puts " " + key.to_s + " \t" + hash[key].to_s
    end
  end

  def self.readline
    hash = {}
    allwords = ""
    while (words = gets)
      break unless words
      allwords += " " + words
    end
    self.count_occurencies(hash, allwords)
    self.printdb(hash)
    hash
  end
end
if __FILE__ == $0
  if ARGV[0] == '-h'
    manual = DATA.read
# html = RDoc :: Markup :: ToHtml.new(RDoc :: Options.new)
    ansi = RDoc::Markup::ToAnsi.new
    puts ansi.convert(manual)
  else
    Dlugosci.readline
  end
end

__END__
= Name

dlugosci.rb - counts the number of occurencies of different word lengths, inputted until EOF.

= SYNOPSIS

dlugosci.rb [-h]

==  Examples

* +dlugosci.rb+ read lines from input until ctrl+d (ctrl+z in Windows)

* <tt>dlugosci.rb -h</tt> displays help

Author ::    Jacek Kuśnierz   (mailto:jkusnierz@student.agh.edu.pl)
