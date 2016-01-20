class CreateClasslists < ActiveRecord::Migration
  def change
    create_table :classlists do |t|

      t.timestamps
    end
  end
end
