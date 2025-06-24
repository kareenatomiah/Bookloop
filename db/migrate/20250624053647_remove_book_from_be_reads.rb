class RemoveBookFromBeReads < ActiveRecord::Migration[7.1]
  def change
    remove_reference :be_reads, :book, null: false, foreign_key: true
  end
end
