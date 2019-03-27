require 'json'
require 'ripl'
require 'set'
require './set_handler'
require './file_handler'

def initdb
  database = {}
  database["titles"] = {}
  database["authors"] = {}
  database["tags"] = {}
  database
end

def book(title, authors, tags)
  book = {}
  book["title"] = title
  book["authors"] = authors
  book["tags"] = tags
  book
end

$db

def setup
  $db = FileHandler.load_string_from_file.empty? ? initdb : FileHandler.load_from_file
end

def insert_book(title, authors, tags)
  newbook = book(title, authors, tags)
  unless $db["titles"].key? title
    $db["titles"][title] = newbook
  end
  for author in authors
    unless $db["authors"].key? author
      $db["authors"][author] = Set.new;
    end
    $db["authors"][author].add(newbook)
  end
  for tag in tags
    unless $db["tags"].key? tag
      $db["tags"][tag] = Set.new;
    end
    $db["tags"][tag].add(newbook)
  end
end

def search_by_title(titlesett)
  title = titlesett[0]
  titleset = Set.new
  for key in $db["titles"].keys
    titleset.add(key)
  end
  titleresult = Set.new
  titleset = titleset.keep_if {
      |v| /#{title}/ =~ v
  }

  for title in titleset
    titleresult.add($db["titles"][title])
  end

  titleresult
end

def search_by_authors(authors)
  authorset = Set.new
  for key in $db["authors"].keys
    authorset.add(key)
  end

  authorresult = Set.new

  if authors.kind_of?(Array)
    for author in authors
      authorset = authorset.keep_if {|v| /#{author}/ =~ v}
    end
    for author in authorset
      if $db["authors"][author].kind_of? Array
        for book in $db["authors"][author]
          authorresult.add(book)
        end
      else
        authorresult.add($db["authors"][author])
      end
    end
  else
    authorset = authorset.keep_if {|v| /#{authors}/ =~ v}

    for author in authorset
      if $db["authors"][author].kind_of? Array
        for book in $db["authors"][author]
          authorresult.add(book)
        end
      else
        authorresult.add($db["authors"][author])
      end
    end
  end
  authorresult
end

def search_by_tags(tags)
  tagset = Set.new
  for key in $db["tags"].keys
    tagset.add(key)
  end
  tagresult = Set.new

  if tags.kind_of?(Array)
    for tag in tags
      tagset = tagset.keep_if {|v| /#{tag}/ =~ v}
    end

    for tag in tags
      if $db["tags"][tag].kind_of? Array
        for book in $db["tags"][tag]
          tagresult.add(book)
        end
      else
        tagresult.add($db["tags"][tag])
      end
    end
  else
    tagset = tagset.keep_if {|v| /#{tags}/ =~ v}

    for tag in tagset
      if $db["tags"][tag].kind_of? Array
        for book in $db["tags"][tag]
          tagresult.add(book)
        end
      else
        tagresult.add($db["tags"][tag])
      end
    end
  end
  tagresult
end

def string_to_regex(args)
  newtable = []
  if args.kind_of?(Array)
    for arg in args
      newtable.push(arg)
    end
  else
    newtable.push(args)
  end
  newtable
end


def search(title, authors, tags)
  results = Set.new
  firstresult = nil
  if title != nil
    results.add(search_by_title(string_to_regex(title)))
    firstresult = search_by_title(string_to_regex(title))
  end
  unless authors == nil || authors.empty?
    results.add(search_by_authors(string_to_regex(authors)))
    if firstresult == nil
      firstresult = search_by_authors(string_to_regex(authors))
    end
  end
  unless tags == nil || tags.empty?
    results.add(search_by_tags(string_to_regex(tags)))
    if firstresult == nil
      firstresult = search_by_tags(string_to_regex(tags))
    end
  end

  results.keep_if {|result| result.to_a[0] != nil}
  puts results
  for result in results
    firstresult = firstresult & result
  end

  puts firstresult

  firstresult
end

def handleArgs(*args)

end

if ARGV.empty?
  setup
  Ripl.start
  module Ripl
    module RedError
      def format_error(error)
        "\e[31m#{super}\e[m"
      end
    end
  end
  Ripl::Shell.include Ripl::RedError
else
  setup
  handleArgs(*ARGV)
end