class CreateAIRs < ActiveRecord::Migration
  def change
    create_table :airs do |t|
      t.references :document, index: true, foreign_key: true
      t.string :name
      t.string :abetOutcome
      t.string :assignee1
      t.string :assignee2
      t.string :assignee3
      t.string :assignee4
      t.string :meetingName
      t.datetime :meetingDate
      t.text :analysis
      t.text :taken
      t.text :conclusion

      t.timestamps null: false
    end
  end
end
