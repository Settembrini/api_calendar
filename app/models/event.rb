class Event < ActiveRecord::Base
    include Swagger::Blocks
    belongs_to :location
    validates :location, presence: {:message => "not found" }, if: 'location_id.present?'
    belongs_to :organizer
    validates :organizer, presence:{:message => "not found" }, if: 'organizer_id.present?'
    has_and_belongs_to_many :themes, class_name: "Theme", join_table: "events_themes"
    accepts_nested_attributes_for :themes
    # validates :theme, :presence => true, if: 'theme_id.present?'
    
    
    #:themes_attributes => [:id, :name]
    #Swagger Model für die Api Doku
    swagger_model :Event do
    key :id, :Event
    key :required, [:id]
    property :id do
    key :type, :integer
    key :format, :int64
    key :description, 'unique identifier for the Theme'
end
property :title do
    key :type, :string
    key :description, 'Titel des Themas'
end
property :description do
    key :type, :string
    key :description, 'Titel des Themas'
end
property :link do
    key :type, :string
    key :description, 'Titel des Themas'
end
property :location_id do
    key :type, :string
    key :description, 'Titel des Themas'
end
property :organizer_id do
    key :type, :string
    key :description, 'Titel des Themas'
end
property :start_time do
    key :type, :dateTime
    key :description, 'Titel des Themas'
end
property :end_time do
    key :type, :dateTime
    key :description, 'Titel des Themas'
end
property :themes do
    key :type, :array
    items do
        key :type, :Theme
    end
end
end




    #Filtert die Events nach dem Jahr und Monat. Optional Tag
    def self.filterEventsPeriod(year, month, day)
        if day !=0
            @events = self.where(:start_time => ( DateTime.parse("#{day}.#{month}.#{year}") .. DateTime.parse("#{day}.#{month}.#{year}").end_of_day))
            else
            @events = self.where(:start_time => ( DateTime.parse("01.#{month}.#{year}") .. DateTime.parse("01.#{month}.#{year}").end_of_month ))
        end
    end

    #Filtert die Ressource Events nach den Eingegebenen Parameter. Z.B. Nach der Location_ID: 1
    def self.filterEventsRessource(params)
    #e = Event.find(params[:id])
        if(!params[:location_id].nil?)
            #render xml: { message: " Location:#{params[:location_id]}" }, status: 200
            @events = Event.where(:location_id => params[:location_id])
        end
        if(!params[:organizer_id].nil?)
            @events = Event.where(:organizer_id => params[:organizer_id])
        end
        if(!params[:theme_id].nil?)
            #th =Theme.find(params[:theme_id])
            #@events =th.events
            @events =  Event.joins(:themes).where(themes: { id: params[:theme_id] })
            # @events = e.themes.where(:id => params[:theme_id])
        end
        @events
    end

end
