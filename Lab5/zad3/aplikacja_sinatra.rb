require 'sinatra'
require 'sinatra/reloader' if development?
require '../zad2/middleware'


class Protected < Sinatra::Base

  get '/' do
    @name = params["name"].nil? ? 'Hello' : params["name"]
    @surname = params["surname"].nil? ? 'World' : params["surname"]
    erb :index, :layout => :my_layout # Renderuj widok 'index'
  end

  if __FILE__ == $0
    use Middleware, ["Jacek", "Kusnierz"]
    run!
  end
end

