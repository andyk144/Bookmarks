require 'sinatra/base'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base
enable :sessions


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
    session[:url] = params[:url]
    redirect '/success'
  end

  get '/success' do
    @url = session[:url]
    erb :success
  end

  run! if app_file == $0
end
