class CreateDefenseCommitteeMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :defense_committee_members do |t|
      t.belongs_to :defense_committee, foreign_key: true
      t.belongs_to :lecturer, foreign_key: { to_table: :users }
      t.integer :role, default: 0

      t.timestamps
    end
  end
end
