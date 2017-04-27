class CreateAbetOutcomes < ActiveRecord::Migration
  def change
    create_table :abet_outcomes do |t|
      t.references :track, index: true, foreign_key: true
      t.string :code
      t.text :desc

      t.timestamps null: false
    end
  end
end
