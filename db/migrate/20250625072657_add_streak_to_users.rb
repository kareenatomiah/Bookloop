class AddStreakToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :streak_count, :integer
    add_column :users, :last_be_read_at, :date
  end
end
