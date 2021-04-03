class AddOrderingTitleEnglishTitleToThesis < ActiveRecord::Migration[6.1]
  def change
    add_column :theses, :ordering, :integer
    add_column :theses, :title, :string
    add_column :theses, :english_title, :string
  end
end
