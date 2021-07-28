class CreateThesesAdvisorEvaluations < ActiveRecord::Migration[6.1]
  def change
    create_table :theses_advisor_evaluations do |t|
      t.belongs_to :theses_member, foreign_key: true
      t.integer :marking1
      t.integer :marking2
      t.integer :marking3
      t.integer :marking4
      t.integer :marking5
      t.integer :marking6
      t.integer :marking7
      t.integer :marking8
      t.integer :marking9
      t.integer :bonus_point
      t.string  :bonus_reason
      t.string  :learning_outcome1
      t.string  :learning_outcome1_remark
      t.string  :learning_outcome2
      t.string  :learning_outcome2_remark
      t.string  :learning_outcome3
      t.string  :learning_outcome3_remark
      t.string  :learning_outcome4
      t.string  :learning_outcome4_remark
      t.string  :learning_outcome5
      t.string  :learning_outcome5_remark
      t.string  :learning_outcome6
      t.string  :learning_outcome6_remark
      t.string  :learning_outcome7
      t.string  :learning_outcome7_remark
      t.string  :learning_outcome8
      t.string  :learning_outcome8_remark
      t.string  :learning_outcome9
      t.string  :learning_outcome9_remark
      t.string  :learning_outcome10
      t.string  :learning_outcome10_remark
      t.string  :learning_outcome11
      t.string  :learning_outcome11_remark
      t.string  :learning_outcome12
      t.string  :learning_outcome12_remark
      t.string  :learning_outcome13
      t.string  :learning_outcome13_remark
      t.string  :learning_outcome14
      t.string  :learning_outcome14_remark
      t.string  :learning_outcome15
      t.string  :learning_outcome15_remark
      t.string  :opinion_about_form
      t.timestamps
    end
  end
end
