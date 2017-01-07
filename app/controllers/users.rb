require 'rack-flash'
class UsersController < ApplicationController
	use Rack::Flash

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
			redirect to "/users"
		else
			erb :"users/new.html"
		end
	end

	# show
	get "/users/:id" do
		@user = User.find(params[:id])
		@versions = @user.versions
		@lists = @versions.collect{|version| version.list}.uniq
		erb :"users/show.html"
	end

	# edit
	get "/users/:id/edit" do
		@user = User.find(params[:id])
		if logged_in?
			if @user.id == current_user.id
				erb :'users/edit.html'
			else
				redirect "/users"
			end
		else
			redirect "/login"
		end
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
		if logged_in?
			if user.destroy
				redirect to "/users"
			else
				erb :'users/edit.html'
			end
		else
			redirect "/users"
		end
	end

end
