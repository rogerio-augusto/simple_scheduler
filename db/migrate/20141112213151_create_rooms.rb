class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name, null: false
      t.integer :pax_limit, default: 1
      t.text :comments

      t.timestamps
    end
  end
end
