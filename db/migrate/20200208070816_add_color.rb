class AddColor < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :color, :string
  end
end
