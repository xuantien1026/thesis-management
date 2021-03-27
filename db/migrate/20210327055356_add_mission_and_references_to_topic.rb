class AddMissionAndReferencesToTopic < ActiveRecord::Migration[6.1]
  def change
    add_column :topics, :mission, :text
    add_column :topics, :references, :string, array: true, default: []
  end
end
