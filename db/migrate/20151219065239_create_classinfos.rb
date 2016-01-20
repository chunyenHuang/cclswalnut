class CreateClassinfos < ActiveRecord::Migration
  def change
    create_table :classinfos do |t|
      t.string :name

      t.timestamps
    end
  end
end
