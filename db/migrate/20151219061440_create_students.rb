class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.integer :user_id
      t.string :user_name
      t.integer :teacher_id
      t.integer :member_id

      t.string :name_chinese
      t.string :firstname
      t.string :lastname
      t.string :middlename
      t.string :nickname
      t.string :phone1
      t.string :phone2
      t.string :phone3
      t.string :email1
      t.string :email2
      t.string :school_elementary
      t.string :school_junior
      t.string :school_high
      t.string :address
      t.date :birthday
      t.string :picture1
      t.string :picture2
      t.text :note

      t.timestamps
    end
  end
end
