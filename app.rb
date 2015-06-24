class App < Sinatra::Base
  get '/' do
    @images = Image.all

    slim :index
  end

  get '/images/:id' do
    @image = Image[params[:id]]

    slim :show
  end

  post '/images' do
    @image = Image.new params[:image]
    @image.save

    redirect '/'
  end
end
