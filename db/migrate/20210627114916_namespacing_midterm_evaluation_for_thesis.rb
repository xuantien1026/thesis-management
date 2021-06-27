class NamespacingMidtermEvaluationForThesis < ActiveRecord::Migration[6.1]
  def change
    rename_table :midterm_evaluations, :theses_midterm_evaluations
    rename_column :theses_midterm_evaluations, :thesis_member_id, :member_id
  end
end
