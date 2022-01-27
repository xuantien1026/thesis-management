class AddThesisProposalReviewerEvaluation < ActiveRecord::Migration[6.1]
  def change
    create_table :thesis_proposals_reviewer_evaluations do |t|
      t.integer :a1, null: false
      t.integer :a2, null: false
      t.integer :b1, null: false
      t.integer :b2, null: false
      t.integer :c1, null: false
      t.integer :c2, null: false
      t.integer :d1, null: false
      t.integer :d2, null: false
      t.integer :e1, null: false
      t.text :e2
      t.date :evaluation_date, null: false
      t.references :thesis_proposal, foreign_key: true, null: false, index: { name: 'index_tp_reviewer_eval_on_tp_id'}
    end
  end
end
