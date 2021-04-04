class AddStudentToThesisMembership < ActiveRecord::Migration[6.1]
  def change
    add_reference :thesis_memberships, :student, foreign_key: { to_table: :users }, null: false
  end
end
