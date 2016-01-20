class CreateAppraisals < ActiveRecord::Migration
  def change
    create_table :appraisals do |t|
      t.integer :number
      t.string :itemnumber
      t.string :descritption
      t.float :value

      t.timestamps
    end
  end
end
