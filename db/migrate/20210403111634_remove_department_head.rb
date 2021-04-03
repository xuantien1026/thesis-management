class RemoveDepartmentHead < ActiveRecord::Migration[6.1]
  def change
    remove_column :departments, :head_id
  end
end
