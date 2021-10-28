class DropMaxStudentCountDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :thesis_proposals, :max_student_count, nil
    change_column_default :theses, :max_student_count, nil
  end
end
