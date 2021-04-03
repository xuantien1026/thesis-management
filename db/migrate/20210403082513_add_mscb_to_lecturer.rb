class AddMscbToLecturer < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :mscb, :string
  end
end
