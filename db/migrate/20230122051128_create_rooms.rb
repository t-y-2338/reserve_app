class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.text :detail
      t.integer :price
      t.string :address
      t.string :image

      t.timestamps
    end
  end
end
