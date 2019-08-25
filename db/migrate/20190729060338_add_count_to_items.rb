class AddCountToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :count, :integer
  end
end
