require './Book.rb'
require './Attribute.rb'

required_filename = ARGV.length > 0 ? ARGV[0] : "./nplik.txt"
all_books_filename = ARGV.length > 1 ? ARGV[1] : "./iplik.txt"
output_filename = ARGV.length > 2 ? ARGV[2] : 'output.txt'

required_file = File.read(required_filename)
all_books_file = File.read(all_books_filename)

rules_file_lines = File.readlines(required_filename)
output_lines = rules_file_lines.select.with_index {|_, i| i < 3}

required_things = []
things = []
attributes = []
$open_thing

all_books_file.each_line do |line|
  if /@.+{.+,/.match(line)
    name = /@.+{.+,/.match(line).to_s
    name = name.sub(/@.+{/, "")
    name = name.sub(/,/, "")
    $open_thing = Book.new(name)
    things.append($open_thing)
  end

  if /.+ = .+/.match(line)
    name = /.+ = .+/.match(line).to_s
    key = name.sub(/ +/, "")
    key = key.sub(/ = .+/, "")

    value = name.sub(/.+ = /, "")
    value = value.gsub(/^["{]/, "")
    value = value.gsub(/["},]*$/, "")


    if /\\.+{/.match(value)
      value = value.gsub(/\\.+{/, "")
      value = value.gsub(/}/, "")
    end

    if key == "author"
      if /.+ and .+/.match(value)
        for author in (value.split(" and "))
          $open_thing.push_author(author)
        end
      else
        $open_thing.push_author(value)
      end
    else
      $open_thing.new_attr(key, value)
    end
  end
  #get_all_books(books,line)
end

def get_needed_book_ids(cites, line)
  while /\\cite *{[^}]*}/.match(line)
    name = /\\cite *{[^}]*}/.match(line).to_s
    line = line.sub(name, "")
    name = name.sub(/\\cite *{/, "")
    name = name.sub(/}/, "")
    cites.append(name)
  end
end

def read_rules(attributes, line)
  if /%%.*/.match(line)
    line = line.gsub("%% ", "")
    names = line.split(" ")
    for field in names
      field = field.to_s
      attr = field.gsub(/{.*}$/, "")
      val = field.gsub(/^.*{/, "")
      val = val.gsub(/[}]$/, "")

      special = nil

      if /["']/.match(val)
        special = "\""
      end

      val = val.gsub("'", "")
      val = val.gsub(/["']$/, "")
      val = val.gsub(/^["']/, "")

      if attr == field
        attr = ""
      end

      attribute = Attribute.new(attr, val)
      unless special.nil?
        attribute.setspecial("\"")
      end
      attributes.push(attribute)
    end
  end
end

required_file.each_line do |line|
  get_needed_book_ids(required_things, line)
  read_rules(attributes, line)
end

required_things_regexp = Regexp.union(required_things)
things.keep_if {|thing| thing.instance_variable_get("@name") =~ required_things_regexp}

File.open(output_filename, 'w') do |f|
  output_lines.each do |line|
    f.write line
  end

  f.write "\\begin{thebibliography}{9}\n"
  space_num = 0
  space = [" "]
  things.each do |thing|
    space_num += 2
    spaceirl = (space * space_num).join(" ")
    f.write spaceirl + "\\bibitem{" + thing.instance_variable_get("@name") + "}" + "\n"

    space_num += 2
    spaceirl = (space * space_num).join(" ")

    attributes.each do |attribute|
      attr = attribute.getname
      value = attribute.getvalue
      if attr != ""
        f.write spaceirl + attr + "{" + thing.get_by_key(value) + "}"
      else
        if attribute.getspecial != nil
          f.write spaceirl + attribute.getspecial + thing.get_by_key(value) + attribute.getspecial
        else
          f.write spaceirl + thing.get_by_key(value)
        end
      end
      if attribute.equal? attributes.last
        f.write "\n"
      else
        f.write ",\n"
      end
    end
    space_num = 0
  end
  f.write "\\end{thebibliography}\n"
  f.write "..."
end