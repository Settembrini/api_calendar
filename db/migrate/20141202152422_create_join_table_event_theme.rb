class CreateJoinTableEventTheme < ActiveRecord::Migration
  def change
      create_table :events_themes, id: false do |t|
          t.integer :event_id
          t.integer :theme_id
      end
  end
end
