class CreateTheses < ActiveRecord::Migration[6.1]
  def change
    create_table :theses do |t|
      t.belongs_to :thesis_proposal
      t.float :midterm_point

      t.timestamps
    end
  end
end
