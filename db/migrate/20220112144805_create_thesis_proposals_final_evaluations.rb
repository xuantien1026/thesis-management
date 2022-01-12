class CreateThesisProposalsFinalEvaluations < ActiveRecord::Migration[6.1]
  def change
    create_table :thesis_proposal_final_evaluations do |t|
      t.references :thesis_proposal, null: false
      t.integer :result, null: false
      t.string :note

      t.timestamps
    end
  end
end
