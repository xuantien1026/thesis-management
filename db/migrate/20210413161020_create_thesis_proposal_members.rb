class CreateThesisProposalMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :thesis_proposal_members do |t|
      t.belongs_to :student
      t.belongs_to :thesis_proposal

      t.timestamps
    end
  end
end
