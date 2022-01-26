class CreateThesisProposalsFinalEvaluations < ActiveRecord::Migration[6.1]
  def change
    create_table :thesis_proposals_final_evaluations do |t|
      t.references :member, null: false
      t.integer :result, null: false
      t.string :note

      t.timestamps
    end
  end
end
