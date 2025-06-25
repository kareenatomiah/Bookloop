class AddPostedToFeedToBeReads < ActiveRecord::Migration[7.1]
  def change
    add_column :be_reads, :posted_to_feed, :boolean
  end
end
