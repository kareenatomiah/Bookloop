class ChangeReviewsBookToWorkKey < ActiveRecord::Migration[6.1]
  def change
    remove_reference :reviews, :book, foreign_key: true
  end
end
