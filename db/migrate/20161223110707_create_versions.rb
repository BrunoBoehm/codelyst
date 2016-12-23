class CreateVersions < ActiveRecord::Migration[5.0]
  def change
  	create_table :versions do |t|
  		t.string :title
  		t.text :description
  		t.integer :list_id
  		t.integer :user_id
  		t.integer :downvotes
  		t.integer :upvotes
  		t.timestamps
  	end
  end
end
