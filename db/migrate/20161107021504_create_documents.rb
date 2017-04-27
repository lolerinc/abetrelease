class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.string :status
      t.datetime :assigned
      t.datetime :due
      t.string :formType

      t.timestamps null: false
    end
  end
end
