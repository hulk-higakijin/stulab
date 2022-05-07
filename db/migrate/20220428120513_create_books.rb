class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.text :introduction
      t.integer :price, default: 1000
      t.integer :likes_count, default: 0

      t.timestamps
    end
  end
end
