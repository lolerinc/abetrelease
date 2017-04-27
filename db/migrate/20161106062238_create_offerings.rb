class CreateOfferings < ActiveRecord::Migration
  def change
    create_table :offerings do |t|
      t.string :CRN
      t.string :section
      t.integer :year
      t.string :term
      t.string :evaluation
      t.references :course, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
