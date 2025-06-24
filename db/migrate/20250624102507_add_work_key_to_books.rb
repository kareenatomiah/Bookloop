class AddWorkKeyToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :work_key, :string
    add_index :books, :work_key
  end
end
