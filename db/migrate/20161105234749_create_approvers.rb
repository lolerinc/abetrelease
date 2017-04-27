class CreateApprovers < ActiveRecord::Migration
  def change
    create_table :approvers do |t|
      t.references :user, index: true, foreign_key: true
      t.references :track, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
