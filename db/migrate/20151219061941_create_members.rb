class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :father_name_chinese
      t.string :father_firstname
      t.string :father_lastname
      t.string :father_middlename
      t.string :father_phone1
      t.string :father_phone2
      t.string :father_phone3
      t.string :father_email1
      t.string :father_email2
      t.string :father_picture

      t.string :mother_name_chinese
      t.string :mother_firstname
      t.string :mother_lastname
      t.string :mother_middlename
      t.string :mother_phone1
      t.string :mother_phone2
      t.string :mother_phone3
      t.string :mother_email1
      t.string :mother_email2
      t.string :mother_picture


      t.string :address1_street
      t.string :address1_city
      t.string :address1_state
      t.integer :address1_zipcode
      t.string :address2_street
      t.string :address2_city
      t.string :address2_state
      t.integer :address2_zipcode
      t.boolean :check_address_same
      t.integer :user_id
      t.string :user_name

      t.timestamps
    end
  end
end
