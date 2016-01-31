class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :signin_id,          null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      
      t.string :name
      t.boolean :check_teacher
      t.boolean :check_member
      t.boolean :check_staff
      t.string :position
      t.string :firstname
      t.string :lastname
      t.string :middlename
      t.string :phone_mobile
      t.string :phone_home
      t.string :phone_work
      t.string :address_street
      t.string :address_city
      t.string :address_state
      t.integer :address_zipcode
      t.string :pic1
      t.string :pic2
      t.string :pic3
      t.string :contact1_name
      t.string :contact1_phone
      t.string :contact1_relationship
      t.string :contact2_name
      t.string :contact2_phone
      t.string :contact2_relationship
      t.text :note
      t.string :document1
      t.string :document2
      t.string :document3
      
      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :signin_id,            unique: true
    add_index :users, :name,                 unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
