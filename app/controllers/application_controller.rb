class ApplicationController < Sinatra::Base
	# required by sinatra-activerecord gem
	register Sinatra::ActiveRecordExtension

	helpers Sinatra::SessionHelpers
	helpers Sinatra::HTMLEscapeHelper
	helpers Sinatra::Language
	helpers Sinatra::ResourceHelper

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
