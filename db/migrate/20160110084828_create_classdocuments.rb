class CreateClassdocuments < ActiveRecord::Migration
  def change
    create_table :classdocuments do |t|
    	t.integer :classlist_id
    	t.integer :teacher_id
    	t.integer :user_id
    	t.string :title
    	t.string :document
    	t.text :note
    	
      t.timestamps
    end
  end
end
