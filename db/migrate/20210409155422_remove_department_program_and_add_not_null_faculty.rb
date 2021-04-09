class RemoveDepartmentProgramAndAddNotNullFaculty < ActiveRecord::Migration[6.1]
  def change
    change_column_null :departments, :faculty_id, false
    remove_column :departments, :program
  end
end
