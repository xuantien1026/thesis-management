class CreateThesisProposals < ActiveRecord::Migration[6.1]
  def change
    create_table :thesis_proposals do |t|
      t.belongs_to :topic

      t.timestamps
    end
  end
end
