class CreateDefenseCommittees < ActiveRecord::Migration[6.1]
  def change
    create_table :defense_committees do |t|
      t.timestamps
    end
  end
end
