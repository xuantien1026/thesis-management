class AddAssignmentDateAndCompletionDateToThesis < ActiveRecord::Migration[6.1]
  def change
    add_column :theses, :assignment_date, :date
    add_column :theses, :completion_date, :date
  end
end
