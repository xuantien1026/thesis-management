class CreateTopicApplication < ActiveRecord::Migration[6.1]
  def change
    create_table :topic_applications do |t|
      t.belongs_to :user, index: { unique: true }
      t.belongs_to :topic

      t.timestamps
    end
  end
end
