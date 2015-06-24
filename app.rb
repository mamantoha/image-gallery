class App < Sinatra::Base
  get '/' do
    @auth = authorized?
    @images = Image.all

    slim :index
  end

  get '/images/:id' do
    @image = Image[params[:id]]

    slim :show
  end

  get '/auth' do
    protected!

    redirect '/'
  end

  post '/images' do
    protected!

    @image = Image.new params[:image]
    @image.save

    redirect '/'
  end

  helpers do
    def protected!
      return if authorized?
      headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
      halt 401, "Not authorized\n"
    end

    def authorized?
      @auth ||= Rack::Auth::Basic::Request.new(request.env)
      @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == ['admin', 'admin']
    end

  end
end
