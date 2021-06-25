class AddSemesterForeignKeyForThesisProposal < ActiveRecord::Migration[6.1]
  def change
    remove_columns :thesis_proposals, :semester_number, :school_year
    add_reference :thesis_proposals, :semester, foreign_key: true, null: false, default: 1

    change_column_default :thesis_proposals, :semester_id, nil
  end
end
