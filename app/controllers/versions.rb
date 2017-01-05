class VersionsController < ApplicationController
	# the notion of version should not be part of the the URL when it's the first version
	# then for additional versions we can make allusion to the version element in the URL


	# index
	get "/versions" do
		@versions = Version.all
		erb :"versions/index.html"
	end

	# show
	get "/lists/:list_id/versions/:id" do
		@list = List.find(params[:list_id])
		@version = Version.find(params[:id])
		erb :"versions/show.html"
	end

	### alternative: edit the first version of a list by adding items in bulk
	# get "/lists/:id/create" do
	# 	@list = List.find_by(id: params[:id])
	# 	@version = @list.versions.first
	# 	@items = 10.times.collect{@version.items.build}
	# 	erb :"versions/create.html"
	# end

	### alternative: edit the first version of a list by adding items one at a time
	get "/lists/:id/add-items" do
		@list = List.find_by(id: params[:id])
		@version = @list.versions.first
		@items = @version.items
		erb :"versions/add-items.html"
	end

	# create a list (create the first version of the list and nested items)
	# post "/lists/:id" do
	# 	list = List.find(params[:id])
	# 	version = list.versions.first
	# 	params[:version][:item].each do |params|
	# 		version.items.create(params) unless params[:title].empty?
	# 	end
	# 	redirect "/lists/#{list.id}"
	# end

	# create the first item of a list
	post "/list/:id" do
		list = List.find(params[:id])
		version = list.versions.first
		item = version.items.build(params[:item])
		if item.save
			redirect "/lists/#{list.id}"
		else
			erb :"versions/add-items.html"
		end	
	end

	# create a new alternate version out of an existing list
	get "/lists/:id/versions/new" do
		@list = List.find(params[:id])
		erb :"versions/new.html"
	end

	post "/lists/:id/versions/new" do
		# {"version"=>{"title"=>"Second version", "description"=>"Version desc", "user_id"=>"2"}, ...}
		list = List.find(params[:id])
		version = list.versions.build(params[:version])
		if version.save
			redirect to "/lists/#{list.id}"
		else
			erb :"versions/new.html"
		end
	end

	# edit a version
	get '/lists/:list_id/versions/:id/edit' do
    	@list = List.find(params[:list_id])
    	@version = Version.find(params[:id])
    	@items = @version.items.all
    	# QUESTION: how to auto increment from 1 instead of version id (guess: new column) ?
    	erb :"versions/edit.html"
  	end

  	# update a version
  	patch "/lists/:list_id/versions/:id/edit" do
    	version = Version.find(params[:id]) 
    	if version.update(params[:version])
    		redirect to "/lists/#{params[:list_id]}/versions/#{params[:id]}"
    	else
    		erb :"versions/edit.html"
    	end
  	end

  	# destroy a version
  	delete "/lists/:list_id/versions/:id/delete" do
  		version = Version.find(params[:id])
  		version.destroy
  		redirect to "/lists/#{params[:list_id]}"
  	end
end