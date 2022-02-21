class AddEndDateToSemester < ActiveRecord::Migration[6.1]
  def up
    add_column :semesters, :end_date, :date
    execute("UPDATE semesters SET end_date = CURRENT_DATE")
    change_column_null :semesters, :end_date, true
  end

  def down
    remove_column :semesters, :end_date
  end
end
