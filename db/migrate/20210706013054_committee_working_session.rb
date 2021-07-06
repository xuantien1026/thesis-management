class CommitteeWorkingSession < ActiveRecord::Migration[6.1]
  def change
    add_column :defense_committees, :session, :integer, default: 0
  end
end
