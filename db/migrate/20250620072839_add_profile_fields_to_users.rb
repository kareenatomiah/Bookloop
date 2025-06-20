class AddProfileFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :date_of_birth, :date unless column_exists?(:users, :date_of_birth)
    add_column :users, :country, :string unless column_exists?(:users, :country)
    add_column :users, :avatar_url, :string unless column_exists?(:users, :avatar_url)
  end
end
