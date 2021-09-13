class AddDepartmentShortName < ActiveRecord::Migration[6.1]
  def change
    add_column :departments, :short_name, :string, null: false, default: 'KHMT'
    change_column_default :departments, :short_name, nil
  end
end
