class AddMssvToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :mssv, :integer
  end
end
