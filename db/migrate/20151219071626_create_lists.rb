class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.integer :tuition

      t.timestamps
    end
  end
end
