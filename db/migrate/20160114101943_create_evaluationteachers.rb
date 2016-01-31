class CreateEvaluationteachers < ActiveRecord::Migration
  def change
    create_table :evaluationteachers do |t|
    	t.integer :user_id
    	t.integer :classlist_id
    	t.float :grade
    	t.float :rate
    	t.text :note
    	

      t.timestamps
    end
  end
end
