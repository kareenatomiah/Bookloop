class RemoveBookIdFromLibraries < ActiveRecord::Migration[7.1]
  def change
    remove_column :libraries, :book_id, :integer
  end
end
