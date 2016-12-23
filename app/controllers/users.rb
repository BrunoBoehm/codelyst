class UsersController < ApplicationController
	get "/users" do
		erb :"users/index.html"
	end
end
