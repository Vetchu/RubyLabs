module Sets
  def Sets.ArrayConstruct(*args)
#    args.each(&method(:puts))

    ary=Array.new(args.join(","))
    for x in ary do
        puts x
    end
  end
  end