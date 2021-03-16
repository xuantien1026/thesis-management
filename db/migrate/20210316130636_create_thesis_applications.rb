class CreateThesisApplications < ActiveRecord::Migration[6.1]
  def change
    create_table :thesis_applications do |t|
      t.belongs_to :user, null: false
      t.belongs_to :topic, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
