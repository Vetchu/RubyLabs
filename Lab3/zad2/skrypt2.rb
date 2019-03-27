module Cw3
  class Odbiorca
    @tab = [1, 2, 3]

    def to_s
      "Wywołano metodę 'to_s()'"
    end

    def inspect
      "Wywołano metodę 'inspect()'"
    end

    def initialize array
      @tab = array
      puts "Wywołano metodę 'initialize()'"
    end

    def utworz_tablice(size, max)
      tab = Array.new(size) {rand(1...max)};
    end

    def utworz_tablice!(size, max)
      @tab = Array.new(size) {rand(1...max)};
    end

    def ilosc_liczb_parzystych
      puts @tab.select {|word| word.to_i % 2 == 0 && word.to_i != 0}.length
    end

    def komunikat
      puts "Wywołano metodę instancyjną 'komunikat()'"
      puts @tab
    end

    def self.komunikat
      puts "Wywołano metodę klasową 'komunikat()'"
      puts @tab
    end
  end # class Odbiorca
end # module Cw3
if $PROGRAM_NAME == __FILE__
  ######################
  # Główna część skryptu
  ######################
  Cw3::Odbiorca.komunikat
  Cw3::Odbiorca.send(:komunikat) # Nawiasy są opcjonalne

  odbiorca = Cw3::Odbiorca.new([4, 5, 6])
  odbiorca.komunikat
  odbiorca.send :komunikat
  odbiorca.ilosc_liczb_parzystych

  puts odbiorca
  p odbiorca
else
  ##########################
  # Przykładowy test 'RSpec'
  ##########################
  RSpec.describe Cw3::Odbiorca do
    before(:each) {@odbiorca = Cw3::Odbiorca.new(nil)}
    it 'displays a message' do
      expect {@odbiorca.komunikat}.to output(/Wywołano metodę instancyjną/).to_stdout
    end
  end # RSpec.describe
end # if $PROGRAM_NAME == __FILE__