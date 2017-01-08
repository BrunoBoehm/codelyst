require 'rack-flash'
class ItemsController < ApplicationController
	use Rack::Flash

	# index
	get "/items" do
		@items = Item.all
		erb :"items/index.html"
	end

	# new item from a list and version
	get "/lists/:list_id/versions/:id/items/new" do
		@list = List.find(params[:list_id])
		@version = Version.find(params[:id])
		owner = @version.user
		if current_user?(owner)
			# order meant to solve a bug due to @item being calculated after Item.new
			@items = @version.items.order(:created_at)
			@item = Item.new
			# provides empty object for the form's values (otherwise nil will prompt error)
			erb :"versions/add-items.html"
		else
			flash[:type], flash[:message] = "warning", "You don't have the permission to add a new item to this version, sorry!"
			redirect to "/lists"
		end
	end

	# create item from a list and version
	post "/lists/:list_id/versions/:id/items" do
		@list = List.find(params[:list_id])
		@version = Version.find(params[:id])
		@items = @version.items
		# will integrate the memory built item if validation fails, overriden in the else condition below
		@item = @version.items.build(params[:item])
		@item.to_lang
		if @item.save
			flash[:type], flash[:message] = "success", "Item created! Great, now create as many steps as needed."
			redirect "/lists/#{@list.id}/versions/#{@version.id}/items/new"
		else
			flash.now[:type], flash.now[:message] = "warning", "Hum... something went wrong, trying saving this step again."
			# .now because there is no redirect, hence the warning would otherwise stay until next redirect (and would be seen on one page where it has no relevance)
			@items = @version.items.to_a[0..-2]
			# this removes the @item object instantiated in memory
			# should also modify view to see value of created item
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

	# update and item from a list and version
	patch "/lists/:list_id/versions/:version_id/items/:id" do
		@list = List.find(params[:list_id])
		@version = Version.find(params[:version_id])
		@item = Item.find(params[:id])
		if @item.update(params[:item])
			@item.to_lang.save
			redirect to "/lists/#{@list.id}/versions/#{@version.id}/edit"
		else
			erb :"items/edit.html"
		end
	end

	# delete
	delete "/lists/:list_id/versions/:version_id/items/:id/delete" do
		item = Item.find(params[:id])
		item.destroy
		flash[:type], flash[:message] = "success", "Well done, item deleted!"
		redirect "/lists/#{params[:list_id]}/versions/#{params[:version_id]}"
	end	
end