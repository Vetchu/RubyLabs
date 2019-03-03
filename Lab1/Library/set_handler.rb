module Sets

  def Sets.hash_construct(*args)
    hash = {}
    for x in args
      hash[x] = x
    end
    hash
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
end