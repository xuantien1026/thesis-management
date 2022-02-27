class AddCommitteeTimings < ActiveRecord::Migration[6.1]
  def change
    add_column :defense_committees, :scheduled_at, :datetime
    add_column :defense_committees, :started_at, :datetime
    add_column :defense_committees, :completed_at, :datetime
    add_column :defense_committees, :location, :string
  end
end
