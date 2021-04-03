class AddStudentToThesisMembership < ActiveRecord::Migration[6.1]
  def change
    add_reference :thesis_memberships, :student, foreign_key: { to_table: :users }, null: false
    add_column :thesis_memberships, :midterm_result, :boolean
    add_column :thesis_memberships, :midterm_note, :string
  end
end
