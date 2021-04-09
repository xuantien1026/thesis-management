class AddFacultyToDepartment < ActiveRecord::Migration[6.1]
  def change
    add_reference :departments, :faculty, foreign_key: true
  end
end
