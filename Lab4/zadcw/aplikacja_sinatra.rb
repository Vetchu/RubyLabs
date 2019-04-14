require 'sinatra'
require 'sinatra/reloader' if development?


class Protected < Sinatra::Base
  get '/' do
    erb :index, :layout => :my_layout
  end

  post '/' do
    @name = params["name"]
    @surname = params["surname"]

    @filename = params[:file][:filename]
    file = params[:file][:tempfile]

    File.open("public/#{@name}_#{@surname}_#{@filename}", 'wb') do |f|
      f.write(file.read)
    end

    erb :index, :layout => :my_layout
  end

  if __FILE__ == $0
    run!
  end
end

