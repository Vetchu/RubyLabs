class Middleware
  def initialize(app, auth)
    @app = app
    @auth = auth
  end

  def call(env)
    request = Rack::Request.new(env)
    name = request.params['name']
    surname = request.params['surname']
    if !name.nil? && !surname.nil?
      return [401, {'Content-Type' => 'text/plain'}, ["bad login\n"]] unless name.downcase == @auth[0].downcase && surname.downcase == @auth[1].downcase
    end

    @app.call(env)
  end
end