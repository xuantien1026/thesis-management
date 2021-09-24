class CreateMajorComposition < ActiveRecord::Migration[6.1]
  def change
    create_table :major_compositions do |t|
      t.references :single_major, foreign_key: { to_table: :majors }
      t.references :multi_major, foreign_key: { to_table: :majors }

      t.timestamps
    end
  end
end
