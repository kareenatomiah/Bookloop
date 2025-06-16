class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :book_name
      t.string :author
      t.text :description
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
