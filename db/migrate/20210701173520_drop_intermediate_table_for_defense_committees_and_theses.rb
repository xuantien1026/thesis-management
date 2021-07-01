class DropIntermediateTableForDefenseCommitteesAndTheses < ActiveRecord::Migration[6.1]
  def change
    drop_table :defense_committee_theses

    add_reference :theses, :defense_committee, foreign_key: true
  end
end
