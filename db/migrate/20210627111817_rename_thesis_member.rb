class RenameThesisMember < ActiveRecord::Migration[6.1]
  def change
    rename_table :thesis_members, :theses_members
  end
end
