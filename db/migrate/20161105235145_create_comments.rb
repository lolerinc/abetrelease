class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :document
      t.text :text
      t.datetime :date
      t.string :type

      t.timestamps null: false
    end
  end
end
