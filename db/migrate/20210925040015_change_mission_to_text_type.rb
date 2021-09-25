class ChangeMissionToTextType < ActiveRecord::Migration[6.1]
  def change
    change_column :thesis_proposals, :mission, :text
    change_column :theses, :mission, :text
  end
end
