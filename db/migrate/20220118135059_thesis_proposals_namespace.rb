class ThesisProposalsNamespace < ActiveRecord::Migration[6.1]
  def change
    rename_table :thesis_proposal_advisors, :thesis_proposals_advisors
    rename_table :thesis_proposal_members, :thesis_proposals_members
  end
end
