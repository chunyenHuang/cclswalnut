class CreateClassdocuments < ActiveRecord::Migration
  def change
    create_table :classdocuments do |t|

      t.timestamps
    end
  end
end
