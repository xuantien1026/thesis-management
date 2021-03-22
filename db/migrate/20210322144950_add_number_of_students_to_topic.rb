class AddNumberOfStudentsToTopic < ActiveRecord::Migration[6.1]
  def change
    add_column :topics, :number_of_students, :integer, null: false, default: 1
    add_check_constraint :topics, "number_of_students >= 1", name: "check_number_of_students"
  end
end
