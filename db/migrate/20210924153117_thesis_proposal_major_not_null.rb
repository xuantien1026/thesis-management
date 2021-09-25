class ThesisProposalMajorNotNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :thesis_proposals, :major_id, false
  end
end
