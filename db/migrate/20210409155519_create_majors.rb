class CreateMajors < ActiveRecord::Migration[6.1]
  def change
    create_table :majors do |t|
      t.string :name, null: false
      t.belongs_to :faculty, foreign_key: true, null: false

      t.timestamps
    end
  end
end
