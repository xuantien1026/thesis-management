class RenameThesisMembershipToThesisMember < ActiveRecord::Migration[6.1]
  def change
    rename_table :thesis_memberships, :thesis_members
    rename_column :midterm_evaluations, :thesis_membership_id, :thesis_member_id
  end
end
