class CreateTeacherdocuments < ActiveRecord::Migration
  def change
    create_table :teacherdocuments do |t|
    	t.integer :user_id
    	t.string :title
    	t.string :file
    	t.text :note

      t.timestamps
    end
  end
end
