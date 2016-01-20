class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :customer_name
      t.string :customer_number
      t.string :customer_address
      t.integer :customer_zipcode
      t.string :customer_note

      t.timestamps
    end
  end
end
