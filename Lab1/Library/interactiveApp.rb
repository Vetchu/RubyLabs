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
  book["title"] = title;
  book["authors"] = authors
  book["tags"] = tags
  book
end
$db
def setup
  $db = FileHandler.load_string_from_file.empty? ? initdb : load_from_file
end

def insert_book(title, authors, tags)
  newbook = book(title, authors, tags)
  unless $db["titles"].key? title
    $db["titles"][title]=newbook
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

def search_by_title(title)
  titleset = $db["titles"].keys
  titleresult = Set.new

  titleset = titleset.keep_if {|v| title =~ v}
  for title in titleset
    titleresult.add($db["titles"][title])
  end
  titleresult
end

def search_by_authors(authors)
  authorset = $db["authors"].keys
  authorresult = Set.new

  for author in authors
    authorset = authorset.keep_if {|v| author =~ v}
  end
  for author in authorset
    for book in $db["authors"][author]
      authorresult.add(book)
    end
  end
  authorresult
end

def search_by_tags(tags)
  tagset = $db["authors"].keys
  tagresult = Set.new

  for tag in tags
    tagset = tagset.keep_if {|v| tag =~ v}
  end

  for tag in tags
    for book in $db["tags"][tag]
      tagresult.add(book)
    end
  end
  tagresult
end

def search(title, authors, tags)
  titleresult=search_by_title(title)
  authorresult=search_by_authors(authors)
  tagresult=search_by_tags(tags)

  titleresult & authorresult & tagresult
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
