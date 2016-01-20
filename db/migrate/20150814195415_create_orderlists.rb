class CreateOrderlists < ActiveRecord::Migration
  def change
    create_table :orderlists do |t|
      t.date :pickup
      t.date :deadline
      t.string :rushnote
      t.string :ordernumber
      t.string :category
      t.string :gold
      t.float :size
      t.integer :quantity
      t.text :description
      t.string :picture
      t.string :caddesigners
      t.string :string
      t.string :setters
      t.string :status_factory
      t.string :status_shipping
      t.string :customer_name
      t.string :customer_phone
      t.integer :itemnumber
      t.integer :invoicenumber
      t.timestamps :status1
      t.timestamps :status2
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
