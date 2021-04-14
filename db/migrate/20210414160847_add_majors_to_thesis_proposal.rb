class AddMajorsToThesisProposal < ActiveRecord::Migration[6.1]
  def change
    add_column :thesis_proposals, :majors, :string, array: true, default: []
  end
end
