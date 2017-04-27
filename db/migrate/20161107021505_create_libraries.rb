class CreateLibraries < ActiveRecord::Migration
  def change
    create_table :libraries do |t|
      t.references :offering, index: true, foreign_key: true
      t.references :document, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
