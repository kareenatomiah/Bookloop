class AddBioAndLocationToUsers < ActiveRecord::Migration[7.1]
  def change
    unless column_exists?(:users, :bio)
      add_column :users, :bio, :text
    end

    unless column_exists?(:users, :location)
      add_column :users, :location, :string
    end
  end
end
