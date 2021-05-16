class ModifySemester < ActiveRecord::Migration[6.1]
  def change
    rename_column :thesis_proposals, :semester, :semester_number
    add_column :thesis_proposals, :school_year, :integer

    rename_column :theses, :semester, :semester_number
    add_column :theses, :school_year, :integer
  end
end
