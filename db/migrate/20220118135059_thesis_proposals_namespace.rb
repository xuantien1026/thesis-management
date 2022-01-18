class ThesisProposalsNamespace < ActiveRecord::Migration[6.1]
  def change
    rename_table :thesis_proposal_advisors, :thesis_proposals_advisors
    rename_table :thesis_proposal_members, :thesis_proposals_members
    rename_table :thesis_proposal_final_evaluations, :thesis_proposals_final_evaluations
  end
end
