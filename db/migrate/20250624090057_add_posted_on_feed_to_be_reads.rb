class AddPostedOnFeedToBeReads < ActiveRecord::Migration[7.1]
  def change
    add_column :be_reads, :posted_on_feed, :boolean
  end
end
