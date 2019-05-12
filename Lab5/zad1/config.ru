require './aplikacja_rack'
require_relative '../zad2/middleware'

use Middleware, ["Jacek", "Kusnierz"]

#use Rack::Reloader, 0 # Użyj aplikacji pośredniczącej 'Rack::Reloader' - http://www.rubydoc.info/gems/rack/Rack/Reloader
run HelloWorld.new # Utwórz instancję aplikacji 'HelloWorld', a następnie uruchom serwer Rack-owy

# Więcej informacji na temat pliku '.ru' znajdziesz na stronie https://github.com/rack/rack/wiki/%28tutorial%29-rackup-howto