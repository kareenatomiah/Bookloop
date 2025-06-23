class AddCaptionToBeReads < ActiveRecord::Migration[7.1]
  def change
    add_column :be_reads, :caption, :string
  end
end
