class AddMajorsToThesis < ActiveRecord::Migration[6.1]
  def change
    add_column :theses, :majors, :string, array: true, default: []
  end
end
