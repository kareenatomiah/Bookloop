class CreateBookMetadata < ActiveRecord::Migration[7.1]
  def change
    create_table :book_metadata do |t|
      t.string :work_key
      t.string :author
      t.string :category
      t.text :description

      t.timestamps
    end
  end
end
