class CreateEOCMs < ActiveRecord::Migration
  def change
    create_table :eocms do |t|
      t.references :document, index: true, foreign_key: true
      t.string :evaluation
      t.text :comment_outcomes
      t.text :comment_worked
      t.text :comment_changes
      t.text :comment_rec
      t.text :comment_implemented
      t.text :comment_results
      t.text :comment_additional
      t.text :comment_failed

      t.timestamps null: false
    end
  end
end
