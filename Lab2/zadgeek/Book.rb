class Book
  @name
  @attr

  def initialize(newname)
    @name = newname;
    @attr = {}
    @attr["author"] = []
  end

  def new_attr(key, value)
    @attr[key] = value
  end

  def push_author(value)
    @attr["author"].push value
  end

  def get_by_key(key)
    if key != "author"
      @attr[key]
    else
      @attr[key].join(", ")
    end
  end

  def to_s
    name = @name + "\n"
    for key in @attr.keys
      if key != "author"
        name += key + "\t" + @attr[key] + "\n"
      else
        name += key
        for author in @attr[key]
          name += "\t" + author
        end
        name += "\n"
      end
    end
    name
  end
end