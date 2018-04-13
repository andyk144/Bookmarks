require 'sinatra/base'
require 'sinatra/flash'
require './lib/bookmark'
require './lib/database'


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
    if Bookmark.create(url: params[:url], name: params[:bookmark_name])
      flash[:message] = "#{params[:url]} was successfully added to your bookmarks list"
    else
      flash[:message] = "Invalid url input - please try again"
    end
    redirect '/'
  end

  post '/bookmarks/delete' do
    Bookmark.delete(params[:id])
    redirect '/bookmarks'
  end

  run! if app_file == $0
end
