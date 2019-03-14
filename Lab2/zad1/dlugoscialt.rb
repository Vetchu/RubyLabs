def count_occurencies(hash, allwords)
  namearr = allwords.split(" ")
  namearr.each {|word| size = word.length
  hash[size] = (hash.key? size) ? hash[size] += 1 : 1
  }
  hash
end

def printdb(hash)
  puts "dlugosc\tilosc"
  for key in hash.keys
    puts " " + key.to_s + " \t" + hash[key].to_s
  end
end

def readline
  hash = {}
  allwords = <<GROCERY_LIST
Grocery list
------------
1. Salad mix.
2. Strawberries.*
3. Cereal.
4. Milk.*

* Organic
GROCERY_LIST

  count_occurencies(hash, allwords)
  printdb(hash)
  return 0
end

readline
