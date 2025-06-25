class AddForeignKeyToBeReadsUser < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :be_reads, :users unless foreign_key_exists?(:be_reads, :users)
  end
end
