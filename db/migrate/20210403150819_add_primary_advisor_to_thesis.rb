class AddPrimaryAdvisorToThesis < ActiveRecord::Migration[6.1]
  def change
    add_reference :theses, :primary_advisor, null: false, foreign_key: { to_table: :users }
  end
end
