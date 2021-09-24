class CreateMajorCommittee < ActiveRecord::Migration[6.1]
  def change
    create_table :major_committees do |t|
      t.string :name, null: false
      t.references :major, foreign_key: true

      t.timestamps
    end

    create_table :major_committee_members do |t|
      t.references :lecturer, foreign_key: { to_table: :users }
      t.references :major_committee, foreign_key: true
      t.timestamps
    end
  end
end
