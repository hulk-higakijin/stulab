class CreateChapters < ActiveRecord::Migration[7.0]
  def change
    create_table :chapters do |t|
      t.integer :number
      t.string :caption
      t.references :book, null: false, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
