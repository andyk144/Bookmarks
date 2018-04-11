require 'sinatra/base'
require 'sinatra/flash'
require './lib/bookmark'


class BookmarkManager < Sinatra::Base
  enable :sessions
  register Sinatra::Flash


  get '/' do
    erb :index
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :bookmarks
  end

  get '/add_new_bookmark' do
    erb :add_new_bookmark
  end

  post '/add' do
    if Bookmark.create(params[:url])
      flash[:message] = "#{params[:url]} was successfully added to your bookmarks list"
    else
      flash[:message] = "Invalid url input - please try again"
    end
    redirect '/'
  end

  # get '/success' do
  #   Bookmark.create(params[:url])
  #   erb :success
  # end

  run! if app_file == $0
end
