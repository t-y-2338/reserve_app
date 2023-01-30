class RenameNameColumnToRooms < ActiveRecord::Migration[6.0]
  def change
    rename_column :rooms, :name, :room_name
  end
end
