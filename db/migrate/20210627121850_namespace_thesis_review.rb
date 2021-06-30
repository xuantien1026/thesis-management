class NamespaceThesisReview < ActiveRecord::Migration[6.1]
  def change
    rename_table :thesis_reviews, :theses_reviews
  end
end
