class CreateStones < ActiveRecord::Migration
  def change
    create_table :stones do |t|
      t.string :report
      t.integer :orderlist_id
      t.string :shape
      t.float :size
      t.integer :amount

      t.timestamps
    end
  end
end
