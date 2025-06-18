class AddWorkKeyToReviews < ActiveRecord::Migration[7.1]
  def change
    add_column :reviews, :work_key, :string
  end
end
