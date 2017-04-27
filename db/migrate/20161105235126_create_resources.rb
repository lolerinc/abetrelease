class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.references :document
      t.text :location

      t.timestamps null: false
    end
  end
end
