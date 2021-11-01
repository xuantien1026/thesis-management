class ChangeReferenceToTextField < ActiveRecord::Migration[6.1]
  def change
    remove_column :theses, :references
    add_column :theses, :reference, :text

    remove_column :thesis_proposals, :references
    add_column :thesis_proposals, :reference, :text
  end
end
