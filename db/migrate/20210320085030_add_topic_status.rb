class AddTopicStatus < ActiveRecord::Migration[6.1]
  def change
    add_column :topics, :status, :integer, default: 0
  end
end
