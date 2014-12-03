class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :link
      t.integer :location_id
      t.integer :organizer_id
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
