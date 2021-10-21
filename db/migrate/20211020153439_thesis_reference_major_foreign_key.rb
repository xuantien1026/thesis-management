class ThesisReferenceMajorForeignKey < ActiveRecord::Migration[6.1]
  def change
    remove_column :theses, :majors
    add_reference :theses, :major, foreign_key: true, null: false
  end
end
