post '/question/vote/:id' do
  @question = Question.find(params[:id])
  case params[:vote]
  	when "down"
  		@question.downvote +=1 
  	when "up"
  		@question.upvote +=1 
  	end

  	@question.save
  	redirect '/home'
end  