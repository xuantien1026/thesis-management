class RenameDefenseCommitteeMember < ActiveRecord::Migration[6.1]
  def change
    rename_table :defense_committee_members, :defense_committees_members
  end
end
