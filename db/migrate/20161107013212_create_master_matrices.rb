class CreateMasterMatrices < ActiveRecord::Migration
  def change
    create_table :master_matrices do |t|
      t.references :track, index: true, foreign_key: true
      t.references :course, index: true, foreign_key: true
      t.references :abet_outcome, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
