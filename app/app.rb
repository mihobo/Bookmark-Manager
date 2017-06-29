# app/app.rb
ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base
  enable :sessions

  get '/links' do
    @user = User.first(:email => session[:email])
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    link = Link.new(url: params[:url], title: params[:title])
    params[:tags].split(', ').each do |tag|
      link.tags << Tag.first_or_create(name:tag)
    end
    link.save
    redirect to '/links'
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  get '/register' do
    erb :'register'
  end

  post '/register' do
    User.create(email: params[:email], password: params[:password])
    session[:email] = params[:email]
    redirect to '/links'
  end
end
