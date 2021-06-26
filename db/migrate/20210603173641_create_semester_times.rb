class CreateSemesterTimes < ActiveRecord::Migration[6.1]
  def change
    create_table :semester_times do |t|
      t.integer :semester_number, require: true
      t.integer :school_year, require: true
      t.date :start_date, require: true

      t.timestamps
    end
  end
end
