class CreateThesesCommitteeEvaluations < ActiveRecord::Migration[6.1]
  def change
    create_table :theses_committee_evaluations do |t|
      t.references :committee_member, foreign_key: { to_table: :defense_committees_members }, null: false
      t.references :member, foreign_key: { to_table: :theses_members }, null: false
      t.integer :marking1, null: false
      t.integer :marking2, null: false
      t.integer :marking3, null: false
      t.integer :marking4, null: false
      t.integer :marking5, null: false
      t.integer :marking6, null: false
      t.integer :marking7, null: false
      t.integer :bonus_point
      t.text :bonus_reason
      t.text :opinion_about_form
      t.timestamps
    end
  end
end
