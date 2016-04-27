require 'bcrypt'


class User < ActiveRecord::Base
	include BCrypt

	has_many :questions
	has_many :answers

	 validates :email, format: {with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, message: "Not a valid email"}
	 validates :email, uniqueness: {message: "This email is already in use"}
	 

	 def password
    	@password ||= Password.new(password_hash)
  	 end

	  def password=(new_password)
	    @password = Password.create(new_password)
	    self.password_hash = @password
	  end

	  def self.authenticate(email, password)
	  	  @user = User.find_by(email: email)
		  password1 = password
		  if @user.password == password1
		    return @user
		  else
		    return nil
		  end
		end

end


#how to raise messgae for errors that match with validate errors