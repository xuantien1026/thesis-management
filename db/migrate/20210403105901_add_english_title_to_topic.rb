class AddEnglishTitleToTopic < ActiveRecord::Migration[6.1]
  def change
    add_column :topics, :english_title, :string
  end
end
