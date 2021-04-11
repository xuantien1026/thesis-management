class MoveTopicFieldsToThesisProposalsAndTheses < ActiveRecord::Migration[6.1]
  def change
    drop_table :topics
    drop_table :topic_applications

    change_table :thesis_proposals do |t|
      t.remove :topic_id
      t.column :ordering, :integer
      t.column :title, :string, null: false
      t.column :english_title, :string
      t.column :mission, :string
      t.column :description, :text
      t.column :references, :string, array: true, default: []
      t.column :max_student_count, :integer, null: false, default: 1
      t.column :status, :integer, default: 0
      t.column :semester, :string
      t.column :education_program, :string
    end

    change_table :theses do |t|
      t.column :mission, :string
      t.column :description, :text
      t.column :references, :string, array: true, default: []
      t.column :max_student_count, :integer, null: false, default: 1
      t.column :status, :integer, default: 0
      t.column :semester, :string
      t.column :education_program, :string
    end

    add_check_constraint :thesis_proposals, "max_student_count >= 1", name: "check_thesis_proposal_max_student_count"
    add_check_constraint :theses, "max_student_count >= 1", name: "check_thesis_max_student_count"
  end
end
