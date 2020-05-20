class AddMessageToPets < ActiveRecord::Migration[5.1]
  def change
    add_column :pets, :hold_for, :string
  end
end
