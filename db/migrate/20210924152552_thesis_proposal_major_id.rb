class ThesisProposalMajorId < ActiveRecord::Migration[6.1]
  def change
    remove_column :thesis_proposals, :majors
    add_reference :thesis_proposals, :major, foreign_key: true
  end
end
