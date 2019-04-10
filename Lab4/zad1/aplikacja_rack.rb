require 'pp' if RUBY_VERSION < '2.5'
require 'nokogiri'

################################
# Klasa z treścią aplikacji Rack
################################
class HelloWorld
  # Metoda będąca 'sercem' aplikacji Rack
  #
  # @param env [Hash] treść żądania
  # @return [Array] odpowiedź dla przeglądarki WWW
  def call(env)
    response = Rack::Response.new

    if env['REQUEST_URI'] =~ /favicon.ico/

      response.status = Rack::Utils::SYMBOL_TO_STATUS_CODE[:not_found] # Ustaw kod statusu (odpowiedzi) na 404
      response.header['Content-Type'] = 'text/plain' # Umieść, w nagłówku odpowiedzi, informację, że wysyłane dane będą zwykłym tekstem
      response.write 'The requested resource does not exist' # Umieść, w ciele odpowiedzi, podany tekst
      response.write "\n" # Metodę 'write()' można uruchamiać wielokrotnie, ... dopóki nie wywołasz 'finish()'
      return response.finish # Nagłówki oraz ciało odpowiedzi są gotowe - wyślij odpowiedź
    end

    puts '*' * 25
    puts "* \e[31mZawartość hasza 'env'\e[0m *"
    puts '*' * 25

    pp env.dup.tap {|key| key.delete('puma.config')}
    ###########################################################

    ###########################################################################
    # Utwórz, w oparciu o tę (surową) treść, obiekt reprezentujący żądanie HTTP
    ###########################################################################
    request = Rack::Request.new(env)
    ################################

    puts '*' * 36
    puts "* \e[31mZawartość hasza 'request.params'\e[0m *"
    puts '*' * 36


    p = request.params


    response.status = Rack::Utils::SYMBOL_TO_STATUS_CODE[:ok] # Ustaw kod statusu na 200. Zbędne, gdyż 200, to wartość domyślna własności 'status'; potrzebne do celów edukacyjnych ;-)
    response.header['Content-Type'] = 'text/html' # Umieść, w nagłówku odpowiedzi, informację, że wysyłane dane będą HTML-em
    response.write %Q(<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Aplikacja Rack</title>
  </head>
  <body>
    <form action="http://localhost:9292/">
      <input name="name">
      <input name="surname">
      <input type="submit">
    </form>
    <h1>#{p["name"].to_s.upcase} #{p["surname"].to_s.upcase}
  </body>
</html>) # Umieść, w ciele odpowiedzi, podany dokument HTML
    response.finish # Wyślij odpowiedź
  end # def call(env)
end # class HelloWorld