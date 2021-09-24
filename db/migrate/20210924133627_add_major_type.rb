class AddMajorType < ActiveRecord::Migration[6.1]
  def change
    add_column :majors, :type, :string, null: false, default: 'SingleMajor'
  end
end
