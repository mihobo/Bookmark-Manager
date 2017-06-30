# app/app.rb
ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base
  enable :sessions
  set :session_secret, 'shhhh secret'

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    link = Link.new(url: params[:url], title: params[:title])
    params[:tags].split(', ').each do |tag|
      link.tags << Tag.first_or_create(name: tag)
    end
    link.save
    redirect to '/links'
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @user = session[:email]
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  get '/user/signup' do
    erb :'user/signup'
  end

  post '/user' do
    user = User.create(email: params[:email], password: params[:password])
    session[:user_id] = user.id
    redirect to '/links'
  end

  get '/user/login' do
    erb :'user/login'
  end

  post '/user/login' do
    User.create(email: params[:email], password: params[:password], confirm_password: params[:confirm_password])
    session[:user_id] = user.id
    redirect to '/links'
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end
end
