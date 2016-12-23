class SessionsController < ApplicationController
	get "/login" do
		erb :"sessions/login.html"
	end

	post "/login" do
		user = User.find_by(name: params[:name], surname: params[:surname])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect "/users"
		else
			erb :"sessions/login.html"
		end
	end	

	get "/logout" do
		session.clear
		redirect "/lists"
	end
end