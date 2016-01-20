class CreateEvaluationteachers < ActiveRecord::Migration
  def change
    create_table :evaluationteachers do |t|

      t.timestamps
    end
  end
end
