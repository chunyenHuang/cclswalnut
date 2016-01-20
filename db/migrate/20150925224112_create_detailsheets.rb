class CreateDetailsheets < ActiveRecord::Migration
  def change
    create_table :detailsheets do |t|
      t.string :weight
      t.string :side1

      t.timestamps
    end
  end
end
