NAME_REGEX = /^[A-Za-zżźćńółęąśŻŹĆĄŚĘŁÓŃ]/

def word_number(word)
  number = word.scan(/\d+/).join('')
  string = word.sub(number.to_s, '').sub("\n", '')
  hash = {}
  unless string.length < 1
    #puts "Wyraz: "+string
    hash["Wyraz"] = string
  end
  unless number.length < 1
    #puts "Liczba: "+number
    hash["Liczba"] = number
  end
  hash
  #{:Liczba =>number, :Wyraz =>string}
end

def readline
  while (words = gets)
    break unless words
    hash = word_number(words)
    if hash.key? "Liczba"
      puts "Liczba: " + hash["Liczba"].to_s
    end
    if hash.key? "Wyraz"
      puts "Wyraz: " + hash["Wyraz"].to_s
    end
  end
end

if __FILE__ == $0

  readline
end



