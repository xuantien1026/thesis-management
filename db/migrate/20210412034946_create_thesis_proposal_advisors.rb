class CreateThesisProposalAdvisors < ActiveRecord::Migration[6.1]
  def change
    create_table :thesis_proposal_advisors do |t|
      t.belongs_to :thesis_proposal, foreign_key: true, null: false
      t.belongs_to :lecturer, foreign_key: { to_table: :users }, null: false
      t.boolean :primary, null: false

      t.timestamps
    end
  end
end
