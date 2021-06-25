class CreateThesisReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :thesis_reviews do |t|
      t.belongs_to :thesis
      t.belongs_to :lecturer

      t.timestamps
    end
  end
end
