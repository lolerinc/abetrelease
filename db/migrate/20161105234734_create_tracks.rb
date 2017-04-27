class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.references :degree, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
  end
end
