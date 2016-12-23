class SessionsController < ApplicationController
	get "/login" do
		erb :"sessions/login.html"
	end

	get "/logout" do
		session.clear
		redirect "/lists"
	end
end