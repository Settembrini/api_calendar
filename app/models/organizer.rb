class Organizer < ActiveRecord::Base
    include Swagger::Blocks
    has_many :events
    
    #Swagger Model für die Api Doku
    swagger_model :Organizer do
    key :id, :Organizer
    key :required, [:id]
    property :id do
    key :type, :integer
    key :format, :int64
    key :description, 'unique identifier for the Organizer'
end
property :name do
    key :type, :string
    key :description, 'Name der Organizer'
end
property :link do
    key :type, :string
    key :description, 'Website der Organizer'
end
end
end
