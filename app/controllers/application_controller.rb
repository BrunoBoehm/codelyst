class ApplicationController < Sinatra::Base
	# required by sinatra-activerecord gem
	register Sinatra::ActiveRecordExtension

	configure do
	  set :public_folder, 'public'
	  set :views, 'app/views'
	end


	get "/" do
		"Hello World"
	end
end
