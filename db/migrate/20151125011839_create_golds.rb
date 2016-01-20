class CreateGolds < ActiveRecord::Migration
  def change
    create_table :golds do |t|
      t.string :invoicenumber
      t.float :Y18

      t.timestamps
    end
  end
end
