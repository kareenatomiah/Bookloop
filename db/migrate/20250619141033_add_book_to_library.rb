class AddBookToLibrary < ActiveRecord::Migration[7.1]
  def change
    add_reference :libraries, :book, foreign_key: true
  end
end
