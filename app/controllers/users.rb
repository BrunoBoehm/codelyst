class UsersController < ApplicationController

	# index 
	get "/users" do
		@users = User.all
		erb :"users/index.html"
	end

	# new
	get "/register" do
		erb :"users/new.html"
	end

	# create
	post "/users/new" do
		user = User.new(params[:user])
		if user.save
			session[:user_id] = user.id
			binding.pry
			redirect to "/users"
		else
			erb :"users/new.html"
		end
	end

	# edit
	get "/users/:id/edit" do
		@user = User.find(params[:id])
		erb :'users/edit.html'
	end

	# update
	patch "/users/:id" do
		user = User.find(params[:id])
		if user.update(params[:user])
			redirect to "/users/#{user.id}/edit"
		else
			erb :'users/edit.html'
		end
	end

	# destroy
	delete "/users/:id" do
		user = User.find(params[:id])
		if user.destroy
			redirect to "/users"
		else
			erb :'users/edit.html'
		end
	end
end
