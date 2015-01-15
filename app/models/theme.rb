class Theme < ActiveRecord::Base
    include Swagger::Blocks
    has_and_belongs_to_many :events, class_name: "Event", join_table: "events_themes"
    accepts_nested_attributes_for :events
    
    #Swagger Model für die Api Doku
    swagger_model :Theme do
    key :id, :Theme
    key :required, [:id]
    property :id do
    key :type, :integer
    key :format, :int64
    key :description, 'unique identifier for the Theme'
end
property :name do
    key :type, :string
    key :description, 'Titel des Themas'
end
end

end
