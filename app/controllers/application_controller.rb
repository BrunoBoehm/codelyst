class ApplicationController < Sinatra::Base
	# required by sinatra-activerecord gem
	register Sinatra::ActiveRecordExtension

	configure do
	  enable :sessions	
	  set :public_folder, 'public'
	  set :views, 'app/views'
	  set :session_secret, "azertysecret"
	end

	get "/" do
		redirect to "/lists"
	end
end
