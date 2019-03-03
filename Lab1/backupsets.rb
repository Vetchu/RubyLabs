
def carr(*args)
  unless args.empty?
    $db["array"].push(Sets.array_construct(*args))
  end
end

def rarr(number)
  puts $db["array"][number]
rescue
  warn "cannot read this position"
end

def uarr(arrindex, position, newval)
  $db["array"][arrindex][position] = newval;
rescue
  warn "cannot update this position"
end

def darr(arrindex)
  $db["array"].delete_at(arrindex)
rescue
  warn "cannot delete this position"
end

def chash(*args)
  unless args.empty?
    $db["hash"].push(Sets.hash_construct(*args))
  end
end

def rhash(key)
  puts $db["hash"][key]
rescue
  warn "cannot read this key"
end

def uhash(index,key, newval)
  $db["hash"][index][key] = newval;
rescue
  warn "cannot update this key"
end

def dhash(index)
  $db["hash"].delete_at(index)
rescue
  warn "cannot delete this hashmap"
end

def cset(*args)
  unless args.empty?
    $db["set"].push(Sets.set_construct(*args))
  end
end

def rset(index)
  puts $db["set"][index]
rescue
  warn "cannot read this set"
end

def uset(index, newval)
  $db["set"][index].add? newval;
rescue
  warn "cannot update this set"
end

def dset(index)
  $db["set"].delete_at(index)
rescue
  warn "cannot delete this set"
end

def initdb
  database = {}
  database["array"]=[]
  database["hash"]=[]
  database["set"]=[]
  database
end
def commit_to_file
  File.open('./db', 'wb') {|f| f.write($db.to_json)}
end

def load_string_from_file
  a = ""
  if File.exist?('./db') && !File.zero?('./db')
    a = File.read('./db')
  end
  a
end

def load_from_file
  $db = JSON.parse(load_string_from_file)
end
def showdb
  puts $db
end