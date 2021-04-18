class RemoveThesisPrimaryAdvisor < ActiveRecord::Migration[6.1]
  def change
    remove_column :theses, :primary_advisor_id
  end
end
