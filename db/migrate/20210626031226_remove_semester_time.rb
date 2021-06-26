class RemoveSemesterTime < ActiveRecord::Migration[6.1]
  def change
    drop_table :semester_times
  end
end
