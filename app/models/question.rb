require 'will_paginate'
require 'will_paginate/active_record'




class Question < ActiveRecord::Base
	
	belongs_to :user
	has_many :answers

	self.per_page = 10

end