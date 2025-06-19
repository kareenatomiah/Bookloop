class AddWorkKeyToLibraries < ActiveRecord::Migration[7.1]
  def change
    add_column :libraries, :work_key, :string
  end
end
