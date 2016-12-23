class ListsController < ApplicationController

	get "/lists" do
		@lists = List.all
		erb :"lists/index.html"
	end

	get "/lists/new" do
		if logged_in?
			erb :"lists/new.html"
		else
			redirect "/login"
		end
	end

	post "/lists/new" do
		if logged_in? && current_user
			list = current_user.lists.build(params[:list])
			if list.save
				Version.create(user_id: current_user.id, list_id: list.id)
				redirect to "/lists/#{list.id}"
			else
				erb :"lists/new.html"
			end
		else
			redirect to "/login"
		end
	end

	get "/lists/:id" do
		@list = List.find_by(id: params[:id])
		if @list
			@contributors = @list.users.all
			erb :"lists/show.html"
		else
			redirect "/lists"
		end
	end
end