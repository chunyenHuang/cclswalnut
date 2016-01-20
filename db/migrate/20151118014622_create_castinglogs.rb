class CreateCastinglogs < ActiveRecord::Migration
  def change
    create_table :castinglogs do |t|
      t.string :weight_today
      t.string :weight_lasttime

      t.timestamps
    end
  end
end
