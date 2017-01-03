class ItemsController < ApplicationController
	get "/items" do
		@items = Item.all
		erb :"items/index.html"
	end

	get "/lists/:list_id/versions/:version_id/item/:id/edit" do
		@list = List.find(params[:list_id])
		@version = Version.find(params[:version_id])
		@item = Item.find(params[:id])
		erb :"items/edit.html"
	end

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