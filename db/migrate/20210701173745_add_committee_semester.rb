class AddCommitteeSemester < ActiveRecord::Migration[6.1]
  def change
    add_reference :defense_committees, :semester, foreign_key: true
  end
end
