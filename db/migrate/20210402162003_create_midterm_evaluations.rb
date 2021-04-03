class CreateMidtermEvaluations < ActiveRecord::Migration[6.1]
  def change
    create_table :midterm_evaluations do |t|
      t.references :thesis_membership, null: false, foreign_key: true
      t.boolean :passed, null: false
      t.string :note

      t.timestamps
    end
  end
end
