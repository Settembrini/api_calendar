class Location < ActiveRecord::Base
    include Swagger::Blocks
    has_many :events
    
swagger_model :Location do
    key :id, :Location
    key :required, [:id]
    property :id do
    key :type, :integer
    key :format, :int64
    key :description, 'unique identifier for the location'
    end
    property :name do
        key :type, :string
        key :description, 'Name der Location'
    end
    property :link do
        key :type, :string
        key :description, 'Website der Location'
    end
    property :street do
        key :type, :string
        key :description, 'Straße auf der sich die Location befindet'
    end
    property :district do
        key :type, :string
        key :description, 'Bezirk auf dem sich die Location befindet'
    end
    property :city do
        key :type, :string
        key :description, 'Stadt auf der sich die Location befindet'
    end
    property :zip do
        key :type, :string
        key :description, 'Postleitzahl der Location'
    end
end

end
