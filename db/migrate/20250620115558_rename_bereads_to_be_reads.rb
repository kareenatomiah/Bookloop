class RenameBereadsToBeReads < ActiveRecord::Migration[7.1]
  def change
    rename_table :bereads, :be_reads
  end
end
