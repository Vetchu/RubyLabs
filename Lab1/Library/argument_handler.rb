require 'getoptlong'
require './interactiveApp'

opts = GetoptLong.new(
    ['--help', '-h', GetoptLong::NO_ARGUMENT],
    ['--search', '-s', GetoptLong::NO_ARGUMENT],
    ['--title', '-t', GetoptLong::REQUIRED_ARGUMENT],
    ['--authors', '-a', GetoptLong::REQUIRED_ARGUMENT],
    ['--tags', '-g', GetoptLong::REQUIRED_ARGUMENT],

    ['--name', GetoptLong::OPTIONAL_ARGUMENT]
)

search_title = nil;
search_authors = Set.new
search_tags = Set.new

repetitions = 1
opts.each do |opt, arg|
  case opt
  when '--help'
    puts <<-EOF
hello [OPTION] ... DIR

-h, --help:
   show help

--repeat x, -n x:
   repeat x times

--name [name]:
   greet user by name, if name not supplied default is John

DIR: The directory in which to issue the greeting.
    EOF
  when '--insert'
    arguments = arg.split(",")
    if arguments.length != 3
      puts "BAD NUMBER OF ARGUMENTS GIVEN"
    else
      title = arguments[0]
      authors = arguments[1].split(".")
      tags = arguments[2].split(".")
      insert_book(title, authors, tags)
    end

  when '--title'
    search_title = arg;
  when '--authors'
    search_authors.merge(arg.split(","))
  when '--tags'
    search_tags.merge(arg.split(","))

  when '--search'
    results = search(search_title, search_authors, search_tags)

    if results.kind_of?(Array)
      results.each {|result|
        puts result["title"].to_s + result["authors"].to_s + result["tags"].to_s
      }
    else

      if results.empty?
        puts "RESULTS: EMPTY"
      else
        puts results
        results = results.to_a[0]
        puts results["title"].to_s + results["authors"].to_s + results["tags"].to_s
      end

    end
    search_title = nil
    search_authors = Set.new
    search_tags = Set.new
  else
    # type code here
  end
end

# if ARGV.length != 1
#   puts "Missing arguments (try --help)"
#   exit 0
# end
#
# dir = ARGV.shift
#
# Dir.chdir(dir)
# for i in (1..repetitions)
#   print "Hello"
#   if name
#     print ", #{name}"
#   end
#   puts
# end