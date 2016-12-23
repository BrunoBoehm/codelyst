module Sinatra
	module SessionHelpers
		def current_user
			@user = User.find_by(id: session[:user_id])
		end

		def logged_in?
			!!session[:user_id]
		end
	end

	helpers SessionHelpers
end