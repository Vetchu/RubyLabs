#!/ usr/bin/env  ruby
require '/home/vetch/.gem/ruby/2.6.0/gems/rdoc-6.1.1/lib/rdoc.rb'
require '/home/vetch/.gem/ruby/2.6.0/gems/ansi-1.5.0/lib/ansi.rb'
if ARGV[0] == '--man'
  manual = DATA.read
# html = RDoc :: Markup :: ToHtml.new(RDoc :: Options.new)
  ansi = RDoc::Markup::ToAnsi.new
  puts ansi.convert(manual)
end
__END__
= Name

pmh -convert.rb - converts  an OAI -PMH  document  into  the   DOAJformat; optionally  also  into  the  DBLP or PBN.

= SYNOPSIS1516pmh -convert.rb [--help] [--man] [--version] [--doajLoginusername] [--doajPass  password] [startDate] [endDate]

==  Examples

* +pmh -polak.rb+   Generate , in   the  current  directory , DOAJfile  for  the  entire  period  of time , i.e., for all (input) records

* <tt>pmh -poal.rb   2013 -01 -01   2013 -07-30</tt> Generate , inthe  current  directory , DOAJ  file  for a given  period  oftime.

Author ::    Jacek Kuśnierz   (mailto:jkusnierz@student.agh.edu.pl)