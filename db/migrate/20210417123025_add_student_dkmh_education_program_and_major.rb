class AddStudentDkmhEducationProgramAndMajor < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :major, :string
    add_column :users, :education_program, :string
    add_column :users, :dkmh, :string
  end
end
