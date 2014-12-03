class Theme < ActiveRecord::Base
    has_and_belongs_to_many :events, class_name: "Event", join_table: "events_themes"
    accepts_nested_attributes_for :events
end
