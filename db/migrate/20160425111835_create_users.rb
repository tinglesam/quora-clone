class CreateUsers< ActiveRecord::Migration
	
	def change
		
		create_table :users do |x|
			x.string :full_name
			x.string :email
			x.string :password_hash, null: false
			x.timestamps null: false
		end

		create_table :questions do |x|
			x.belongs_to :user, index: true
			x.text :text
			#has a user_id
			x.timestamps null: false
		end


		create_table :answers do |x|
			x.belongs_to :user, index: true
			x.belongs_to :question, index: true
			x.text :text
			#has a user_id
			x.timestamps null: false
		end

		# create_join_table :answers, :questions do |x|
		# 	x.index :answer_id
		# 	x.index :question_id
		# end	
	end
end	


#diff btween base and Migration
#declare primary keys
#need a juncyion table?
