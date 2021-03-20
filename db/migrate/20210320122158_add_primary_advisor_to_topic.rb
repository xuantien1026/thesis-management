class AddPrimaryAdvisorToTopic < ActiveRecord::Migration[6.1]
  def change
    add_reference :topics, :primary_advisor, foreign_key: { to_table: :users }, null: false
  end
end
