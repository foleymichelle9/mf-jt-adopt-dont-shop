class AddImageToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :image, :string
  end
end
