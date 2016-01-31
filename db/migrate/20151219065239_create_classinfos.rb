class CreateClassinfos < ActiveRecord::Migration
  def change
    create_table :classinfos do |t|
      t.integer :student_id
      t.integer :classlist_id
      t.string :class_name
      t.text :note
      t.boolean :check_pay
      t.float :tuition

      t.string :quiz1
      t.string :quiz2
      t.string :quiz3
      t.string :quiz4
      t.string :quiz5
      t.string :midterm
      t.string :final

      t.timestamps
    end
  end
end
