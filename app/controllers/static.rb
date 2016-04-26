require 'byebug'
require 'bcrypt'
require 'sinatra'
require_relative '../models/user.rb'

enable :sessions 

#go home

get '/home' do 
  erb :"urls/home"
end

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




get '/urls/profile/:id' do 
	@user = User.find(params[:id])
	erb :"urls/profile"
end	

get '/logout' do
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

#click on ask button 

get '/urls/askpage' do 
  erb :"urls/ask"
end

#adds quesiton to the table 
post '/ask' do
  @question = Question.create(params[:question])
  @question.user_id = session[:user_id]
  @question.save
  erb :"urls/home"
end  




#if login is legit
get '/urls/:id' do 
  session[:start_time]  ||= Time.now.getutc 
  @user = User.find(params[:id])
  session[:user_name] = @user.full_name
  session[:user_id] = params[:id]
  @user = User.find(params[:id])
  erb :"urls/home"
end 

get '/question/:id' do 
  @question = Question.find(params[:id])
  erb :'urls/onequestion'

end


#the id is that of the question 
post '/answer/:id' do
  @answer = Answer.create(params[:answer])
  @answer.user_id = session[:user_id]
  @answer.question_id = params[:id]
  @answer.save
  
  redirect '/home'
end  

   
get '/profile/myqa' do 
  erb :'urls/myqa'

end














