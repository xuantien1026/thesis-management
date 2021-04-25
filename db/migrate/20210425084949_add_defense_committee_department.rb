class AddDefenseCommitteeDepartment < ActiveRecord::Migration[6.1]
  def change
    add_reference :defense_committees, :department, foreign_key: true
  end
end
