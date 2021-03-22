class AddTopicProgram < ActiveRecord::Migration[6.1]
  def change
    add_column :topics, :program, :string, null: false
  end
end
