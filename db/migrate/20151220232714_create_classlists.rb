class CreateClasslists < ActiveRecord::Migration
  def change
    create_table :classlists do |t|
    	t.integer :teacher_id
    	t.integer :user_id
    	t.boolean :active
    	t.integer :year
    	t.string :class_name
    	t.string :kind
    	t.string :place
    	t.float :tuition
    	t.float :tuition_count
    	t.text :note
    	t.date :date_from
    	t.date :date_to
    	t.time :time_from
    	t.time :time_to

      t.timestamps
    end
  end
end
