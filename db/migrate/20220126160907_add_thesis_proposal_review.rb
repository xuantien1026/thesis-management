class AddThesisProposalReview < ActiveRecord::Migration[6.1]
  def change
    create_table :thesis_proposals_reviews do |t|
      t.references :lecturer, foreign_key: { to_table: :users }, null: false
      t.references :thesis_proposal, foreign_key: true, null: false
      t.timestamps
    end
  end
end
