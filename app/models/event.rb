class Event < ActiveRecord::Base
    belongs_to :location
    validates :location, presence: {:message => "not found" }, if: 'location_id.present?'
    belongs_to :organizer
    validates :organizer, presence:{:message => "not found" }, if: 'organizer_id.present?'
    has_and_belongs_to_many :themes, class_name: "Theme", join_table: "events_themes"
    accepts_nested_attributes_for :themes
    # validates :theme, :presence => true, if: 'theme_id.present?'
    
    
    
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
