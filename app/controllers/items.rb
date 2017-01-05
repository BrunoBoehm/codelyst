class ItemsController < ApplicationController
	# index
	get "/items" do
		@items = Item.all
		erb :"items/index.html"
	end

	# new item from a list and version
	get "/lists/:list_id/versions/:id/items/new" do
		@list = List.find(params[:list_id])
		@version = Version.find(params[:id])
		@items = @version.items
		erb :"versions/add-items.html"
	end

	# create item from a list and version
	post "/lists/:list_id/versions/:id/items" do
		list = List.find(params[:list_id])
		version = Version.find(params[:id])
		item = version.items.build(params[:item])
		if item.save
			redirect "/lists/#{list.id}"
		else
			erb :"versions/add-items.html"
		end	
	end	

	# edit an item from a list and version
	get "/lists/:list_id/versions/:version_id/item/:id/edit" do
		@list = List.find(params[:list_id])
		@version = Version.find(params[:version_id])
		@item = Item.find(params[:id])
		erb :"items/edit.html"
	end

	# update and intem from a list and version
	patch "/lists/:list_id/versions/:version_id/items/:id" do
		@list = List.find(params[:list_id])
		@version = Version.find(params[:version_id])
		@item = Item.find(params[:id])
		if @item.update(params[:item])
			redirect to "/lists/#{@list.id}/versions/#{@version.id}/edit"
		else
			erb :"items/edit.html"
		end
	end
end