class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
    	t.integer :user_id
    	t.integer :member_id
    	t.float :amount
    	t.string :checknumber
    	t.boolean :cash
    	t.text :note
    	t.string :picture1
    	t.string :picture2
    	t.string :picture3
    	t.string :picture4

      t.timestamps
    end
  end
end
