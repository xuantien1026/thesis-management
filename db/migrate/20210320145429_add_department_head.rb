class AddDepartmentHead < ActiveRecord::Migration[6.1]
  def change
    add_reference :departments, :head, foreign_key: { to_table: :users }, null: false
  end
end
