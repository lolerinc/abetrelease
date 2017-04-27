class CreatePIEs < ActiveRecord::Migration
  def change
    create_table :pies do |t|
      t.references :document, index: true, foreign_key: true
      t.text :name
      t.string :abet_outcome
      t.text :description
      t.float :tpercent
      t.text :tscore
      t.float :rpercent
      t.string :rscore
      t.text :calculation

      t.timestamps null: false
    end
  end
end
