class VersionsController < ApplicationController

	# index
	get "/versions" do
		@versions = Version.all
		erb :"versions/index.html"
	end

	# edit the first version of a list by working directly on its items
	get "/lists/:id/create" do
		@list = List.find_by(id: params[:id])
		@version = @list.versions.first
		@items = 10.times.collect{@version.items.build}
		erb :"versions/init.html"
	end

	# create a list (create the first version of the list and nested items)
	post "/lists/:id" do
		list = List.find(params[:id])
		version = list.versions.first
		params[:version][:item].each do |params|
			version.items.create(params) unless params[:title].empty?
		end
		redirect "/lists/#{list.id}"
	end

	get '/lists/:list_id/versions/:id/edit' do
    	@list = List.find(params[:list_id])
    	@version = Version.find(params[:id])
    	@items = @version.items.all
    	# how to auto increment from 1 instead of version id ?
    	erb :"versions/edit.html"
  	end
end