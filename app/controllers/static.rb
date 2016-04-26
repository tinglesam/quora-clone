require 'byebug'
require 'bcrypt'
require 'sinatra'
require_relative '../models/user.rb'

enable :sessions 



get '/' do
  erb :"static/index"
end

post '/signup' do
  @user = User.new(params[:user])
  @user.password = params[:password]
  if @user.save
    redirect "/urls/#{@user.id}"
  else
    redirect '/urls/error'
  end
end  


get '/urls/error' do 

	erb :"urls/error"
end	

#if login is legit
get '/urls/:id' do 
	session[:start_time]  ||= Time.now.getutc 
	session[:user_id] = params[:id]
	@user = User.find(params[:id])
	erb :"urls/home"
end	


get '/urls/profile/:id' do 
	@user = User.find(params[:id])
	erb :"urls/profile"
end	

get '/logout' do
	byebug
  session[:user_id] = nil
  session[:end_time] = Time.now.getutc
  redirect '/'
end

#once you move autheniticate to the model how do you direct in controller 
post '/login' do 

  @user = User.authenticate(params[:email], params[:password])
  if @user
  	redirect "/urls/#{@user.id}"
  else
  	redirect "/urls/error"
  end

end



