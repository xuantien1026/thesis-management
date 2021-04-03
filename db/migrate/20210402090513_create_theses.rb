class CreateTheses < ActiveRecord::Migration[6.1]
  def change
    create_table :theses do |t|
      t.belongs_to :thesis_proposal

      t.timestamps
    end
  end
end
