class AddSemesterForeignKeyForThesis < ActiveRecord::Migration[6.1]
  def change
    remove_columns :theses, :semester_number, :school_year
    add_reference :theses, :semester, foreign_key: true, null: false, default: 1

    change_column_default :theses, :semester_id, nil
  end
end
