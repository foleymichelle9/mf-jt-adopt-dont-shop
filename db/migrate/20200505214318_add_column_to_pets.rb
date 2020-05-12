class AddColumnToPets < ActiveRecord::Migration[5.1]
  def change
    add_column :pets, :description, :text
  end
end
