class RemoveMidtermResultFromThesisMembership < ActiveRecord::Migration[6.1]
  def change
    remove_column :thesis_memberships, :midterm_result
    remove_column :thesis_memberships, :midterm_note
  end
end
