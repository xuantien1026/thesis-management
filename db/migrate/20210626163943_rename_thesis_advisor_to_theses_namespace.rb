class RenameThesisAdvisorToThesesNamespace < ActiveRecord::Migration[6.1]
  def change
    rename_table :thesis_advisors, :theses_advisors
  end
end
