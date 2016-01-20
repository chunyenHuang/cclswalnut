class CreateTextbooks < ActiveRecord::Migration
  def change
    create_table :textbooks do |t|

      t.timestamps
    end
  end
end
