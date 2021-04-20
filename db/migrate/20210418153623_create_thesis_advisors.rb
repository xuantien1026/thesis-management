class CreateThesisAdvisors < ActiveRecord::Migration[6.1]
  def change
    create_table :thesis_advisors do |t|
      t.belongs_to :lecturer, foreign_key: { to_table: :users }
      t.belongs_to :thesis, foreign_key: true
      t.boolean :primary, null: false, default: false

      t.timestamps
    end
  end
end
