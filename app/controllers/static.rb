require 'byebug'
require 'bcrypt'
require 'sinatra'

enable :sessions 

#go home

# @question_sorted = []
# @answer_sorted = []


get '/home' do 
    @question_sorted = Question.order(upvote: :desc).paginate(:page=> params[:page], :per_page =>5)

    # Question.all.each do |ques|
    #   @question_sorted << ques
    #   @question_sorted.sort! { |a,b| b.upvote <=> a.upvote }
    # end
    @answer_sorted = Answer.order(upvote: :desc)
    # Answer.all.each do |ques|
    #   @answer_sorted << ques
    #   @answer_sorted.sort! { |a,b| b.upvote <=> a.upvote }
    # end

  erb :"urls/home"
end

# get '/home' do 
#   erb :"urls/home"
# end




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
  session[:user] = nil
  redirect '/'
end
get '/login' do
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
  if params[:text].length > 3
    @question = Question.create(text: params[:text])
    @question.user_id = session[:user_id]
    @question.upvote = 0
    @question.downvote = 0
    @question.save
    redirect '/home'
  end
  redirect '/home'
end  




#if login is legit
get '/urls/:id' do 
  session[:start_time]  ||= Time.now.getutc 
  @user = User.find(params[:id])
  session[:user] = @user

  session[:user_name] = @user.full_name
  session[:user_id] = params[:id]
  @user = User.find(params[:id])
  redirect '/home'
end 

get '/question/:id' do 
  @question = Question.find(params[:id])
  

  erb :'urls/onequestion'

end


#the id is that of the question 
post '/answer/:id' do
  @answer = Answer.create(text: params[:answer])
  @answer.user_id = session[:user_id]
  @answer.question_id = params[:id]
  @answer.upvote = 0
  @answer.downvote = 0
  @answer.save

  {answer: @answer, user_name: @answer.user.full_name}.to_json #is the result for jquery 
end  

   
get '/profile/myqa' do 
  erb :'urls/myqa'

end


post '/question/qid/vote/:status' do
  @question = Question.find(params[:quesid])
  case params[:status]
    when "downvote"
      @question.downvote += 1
    when "upvote"
      @question.upvote += 1 
    end

    @question.save
    redirect '/home'
end  

post '/answer/aid/vote/:status' do
  @answer = Answer.find(params[:answid])
  case params[:status]
    when "downvote"
      @answer.upvote -= 1
    when "upvote"
      @answer.upvote += 1 
    end

    @answer.save
    redirect '/home'
end  









