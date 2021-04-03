class CreateThesisMemberships < ActiveRecord::Migration[6.1]
  def change
    create_table :thesis_memberships do |t|
      t.belongs_to :thesis
      t.boolean :midterm_result
      t.string :midterm_note

      t.timestamps
    end
  end
end
