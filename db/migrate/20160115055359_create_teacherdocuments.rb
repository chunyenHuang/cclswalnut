class CreateTeacherdocuments < ActiveRecord::Migration
  def change
    create_table :teacherdocuments do |t|

      t.timestamps
    end
  end
end
