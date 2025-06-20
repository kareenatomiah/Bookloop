class AddTextToBeReads < ActiveRecord::Migration[7.1]
  def change
    add_column :be_reads, :text, :string
  end
end
