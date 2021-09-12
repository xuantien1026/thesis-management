class RemoveColumnsForReviewerEvaluation < ActiveRecord::Migration[6.1]
  def change
    remove_column :theses_reviewer_evaluations, :learning_outcome10
    remove_column :theses_reviewer_evaluations, :learning_outcome11
    remove_column :theses_reviewer_evaluations, :learning_outcome12
    remove_column :theses_reviewer_evaluations, :learning_outcome13
    remove_column :theses_reviewer_evaluations, :learning_outcome14
    remove_column :theses_reviewer_evaluations, :learning_outcome15
    remove_column :theses_reviewer_evaluations, :learning_outcome10_remark
    remove_column :theses_reviewer_evaluations, :learning_outcome11_remark
    remove_column :theses_reviewer_evaluations, :learning_outcome12_remark
    remove_column :theses_reviewer_evaluations, :learning_outcome13_remark
    remove_column :theses_reviewer_evaluations, :learning_outcome14_remark
    remove_column :theses_reviewer_evaluations, :learning_outcome15_remark
  end
end
