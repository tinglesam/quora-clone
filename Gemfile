source 'https://rubygems.org'

# Ruby Version
# ruby "2.2.1"

# Adding Sinatra Drivers
gem 'sinatra'
gem 'sinatra-contrib'

# Adding thin gem as advised
gem 'thin'

# Adding ActiveRecord and Database Components
gem 'activerecord'
gem 'activesupport'
gem 'sinatra-activerecord'

# Adding Database elements
gem 'pg'
gem 'bcrypt', '~> 3.1.7'

gem 'byebug'
gem 'acts_as_votable'

# Adding rake for management
gem 'rake'
gem 'will_paginate', '~> 3.1.0'

# Adding rspec for running unit testing
gem 'rspec'

group :development, :test do
	# Adding shotgun for local web hosting
	gem 'shotgun'
end

group :production do
	# Heroku
	# ==================
	gem 'rails_12factor' # Heroku Gem Supports
	gem 'puma' # Using puma for
end