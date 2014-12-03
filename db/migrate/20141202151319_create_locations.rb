class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :link
      t.string :street
      t.string :district
      t.string :city
      t.integer :zip

      t.timestamps
    end
  end
end
