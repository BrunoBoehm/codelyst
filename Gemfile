source 'https://rubygems.org'

gem "sinatra"
gem "rake"
gem "activerecord"
gem "rack-flash3"
gem "sinatra-activerecord"
gem "bcrypt"
gem "pry"

group :development do
	gem "shotgun"	# no need to restart the server at every change, can start server using console "shotgun" command
	gem "tux"
	gem "sqlite3"
end

group :test do
	gem "rspec"
	gem "capybara"
end

group :production do
	gem "pg"
end