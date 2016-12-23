class UsersController < ApplicationController
	get "/users" do
		@users = User.all
		erb :"users/index.html"
	end

	get "/register" do
		erb :"users/new.html"
	end
end
