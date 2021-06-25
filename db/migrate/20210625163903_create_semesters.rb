class CreateSemesters < ActiveRecord::Migration[6.1]
  def change
    create_table :semesters do |t|
      t.integer :number, null: false
      t.integer :academic_year, null: false
      t.date :start_date, null: false

      t.timestamps
    end
  end
end
