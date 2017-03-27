require 'rack-flash'
class ListsController < ApplicationController
	use Rack::Flash

	# index
	get "/lists" do
		@lists = List.all
		erb :"lists/index.html"
	end

	#  new
	get "/lists/new" do
		if logged_in?
			erb :"lists/new.html"
		else
			flash[:type], flash[:message] = "warning", "Hum... you should try to log in first!"
			redirect "/login"
		end
	end

	# create
	post "/lists/new" do
		if logged_in? && current_user
			list = current_user.lists.build(params[:list])
			if list.save
				# create the associated version join model instance
				version = Version.create(user_id: current_user.id, list_id: list.id)
				# a new list was just created, now for that list's first version we want to add items
				flash[:type], flash[:message] = "success", "Congratulations, you just created a new list."
				redirect to "/lists/#{list.id}/versions/#{version.id}/items/new"
				# this route should only be accessible to the creator of the list (or the creator of the list's first version)
			else
				flash.now[:type], flash.now[:message] = "warning", "Sorry, something went wront, try again."
				erb :"lists/new.html"
			end
		else
			flash[:type], flash[:message] = "warning", "Hum... you should try to log in first!"
			redirect to "/login"
		end
	end

	# show
	get "/lists/:id" do
		@list = List.find_by(id: params[:id])
		@files = @list.versions.first.items.order(:path).reject{ |item| item.path.empty? || item.path.downcase == "console" }.uniq{ |file| file.path }
		if @list
			@first_version = @list.versions.first
			@first_version_items = @first_version.items.order(:created_at)
			@contributors = @list.users.all
			@versions = @list.versions.first(3)
			erb :"lists/show.html"
		else
			redirect "/lists"
		end
	end

	# update
	patch "/lists/:id/edit" do
		list = List.find(params[:id])
		if list.update(params[:list])
			flash[:type], flash[:message] = "success", "List edited successfully, see for yourself!"
			redirect to "/lists/#{params[:id]}"
		else
			flash[:type], flash[:message] = "warning", "Sorry... Could not edit this list, try again please."
			redirect to "/lists/#{params[:id]}"
		end
	end

	# index 1 list's versions
	get "/lists/:id/versions" do
		@list = List.find(params[:id])
		@versions = @list.versions.all
		erb :"lists/versions.html"
	end
end
