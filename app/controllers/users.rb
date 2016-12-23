class UsersController < ApplicationController
	get "/users" do
		@users = User.all
		erb :"users/index.html"
	end

	get "/register" do
		erb :"users/new.html"
	end

	post "/users/new" do
		# {"user"=>{"name"=>"Luke", "surname"=>"Skywalker", "description"=>"I'm son of a Jedi turned Sith, how cool is that?"}}
		user = User.new(params[:user])
		if user.save
			redirect to "/users"
		else
			erb :"users/new.html"
		end
	end

	get "/users/:id/edit" do
		@user = User.find(params[:id])
		erb :'users/edit.html'
	end

	
end
