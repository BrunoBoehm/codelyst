module Sinatra
	module SessionHelpers
		def current_user
			@user = User.find_by(id: session[:user_id])
		end

		def logged_in?
			!!session[:user_id]
		end

		def current_user?(user)
			current_user && current_user.id == user.id
		end
	end

	helpers SessionHelpers
end