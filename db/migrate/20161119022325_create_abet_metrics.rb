class CreateAbetMetrics < ActiveRecord::Migration
  def change
    create_table :abet_metrics do |t|
      t.references :offering, index: true, foreign_key: true
      t.string :abet
      t.string :rating

      t.timestamps null: false
    end
  end
end
