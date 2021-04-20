class CreateDefenseCommitteeTheses < ActiveRecord::Migration[6.1]
  def change
    create_table :defense_committee_theses do |t|
      t.belongs_to :defense_committee, foreign_key: true
      t.belongs_to :thesis, foreign_key: true

      t.timestamps
    end
  end
end
