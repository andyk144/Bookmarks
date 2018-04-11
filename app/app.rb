require 'sinatra/base'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base

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
    Bookmark.create(params[:url])
    redirect '/'
  end

  # get '/success' do
  #   Bookmark.create(params[:url])
  #   erb :success
  # end

  run! if app_file == $0
end
