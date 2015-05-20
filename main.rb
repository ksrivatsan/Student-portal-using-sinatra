require 'sinatra'
require 'slim'
require 'sass'
require './student.rb'

configure do
  enable :sessions
  set :username, 'frank'
  set :password, 'sinatra'
end

configure :development do
  DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/student.db")
end

configure :production do
  DataMapper.setup(:default, ENV['DATABASE_URL'])
  # DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://ahybktfzdxclth:F5eGwK8G_3g0fzH_cGwJoRcQI1@ec2-23-23-126-39.compute-1.amazonaws.com:5432/d5t2hvcqltlg4g')
end

get('/styles.css'){ scss :styles }

get '/' do
  slim :login
end

get '/home' do
  slim :home
end

get '/about' do
  @title = "All About This Website"
  slim :about
end

get '/contact' do
  slim :contact
end

not_found do
  slim :not_found
end

get '/login' do
  slim :login
end

post '/login' do
  if params[:username] == settings.username && params[:password] == settings.password
    session[:admin] = true
    redirect to('/students')
  else
    slim :login
  end
end

get '/logout' do
  session.clear
  redirect to('/login')
end

get '/set/:name' do
  session[:name] = params[:name]
end

get '/get/hello' do
  "Hello #{session[:name]}"
end