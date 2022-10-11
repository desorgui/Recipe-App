class AddDescriptionToInventories < ActiveRecord::Migration[7.0]
  def change
    add_column :inventories, :description, :text, null: false
  end
end
