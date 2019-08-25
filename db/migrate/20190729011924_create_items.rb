class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :title
      t.integer :price
      t.datetime :time
      t.timestamps null: false
    end
  end
end
