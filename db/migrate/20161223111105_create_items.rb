class CreateItems < ActiveRecord::Migration[5.0]
  def change
  	create_table :items do |t|
  		t.string :title
  		t.text :description
  		t.integer :version_id
  		t.integer :order
  		t.text :code
  		t.text :notes
  		t.string :language
  		t.string :path
  		t.timestamps
  	end
  end
end
