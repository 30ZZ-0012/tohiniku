class AddDatetimeToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :datetime, :datetime
  end
end