class UpdateForeignKeyToReviews < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :reviews, :shelters

    add_foreign_key :reviews, :shelters, on_delete: :cascade
  end
end
