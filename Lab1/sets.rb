require 'set'

module Sets
  def Sets.array_construct(*args)
#    args.each(&method(:puts))
    ary = Array.new(args)
    for x in ary do
      puts x
    end
    ary
  end

  def Sets.hash_construct(*args)
    hash = {}
    for x in args
      hash[x] = x
    end
    hash
  end

  def Sets.set_construct(*args)
    set = Set.new()
    for x in args
      set.add(x);
    end
    set
  end

  def Sets.hash_insert(hash, key, value)
    unless hash.key? key
      hash[key] = []
    end

    tab = hash.fetch(key)
    unless tab.include? value || tab.length > 1
      tab.push(value)
    end
  end

  def Sets.person_insert(hash, key, value, secondhash)
    unless hash.key? key
      hash[key] = []
    end

    tab = hash.fetch(key)
    if (secondhash[value] != nil && secondhash[value].length < 1) || tab.length == 2
      #raise("OSOBA " + value + " JEST JUZ ZAPISANA NA " + key)
      raise(StandardError)
    elsif !(tab&.include? value)
      tab.push(value)
    end

    unless secondhash.key? value
      secondhash[value] = []
    end
  end

  def Sets.hash_get_by_key(hash, key, secondhash)
    if hash.key? key
      a = hash.fetch(key)
    end

    for name in a
      oceny = secondhash.fetch(name)
      for ocena in oceny
        name = name + " " + ocena
      end
      puts name
    end
  end

  def Sets.hash_get_all(hash, secondhash)
    for key in hash.keys
      if key != nil
        puts key
        Sets.hash_get_by_key(hash, key, secondhash)
      end
    end
  end
end


def handleArgs(*args)
  hash = {}
  secondhash = {}
  for x in args do
    x = x.to_s
    carr = x.split(':')
    if carr[0] == '--wypisz'
      if carr.length > 1
        Sets.hash_get_by_key(hash, carr[1], secondhash)
      else
        Sets.hash_get_all(hash, secondhash)
      end
    else
      if carr.length > 2
        Sets.hash_insert(secondhash, carr[1], carr[2])
      end
      Sets.person_insert(hash, carr[0], carr[1], secondhash)


    end
  end
  [hash, secondhash]
end

if __FILE__ == $0
  if ARGV.empty?
    puts "argumenty?"
  else
    handleArgs(*ARGV)
  end
end
