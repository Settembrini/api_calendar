class EventsController < ApplicationController
    before_action :set_event, only: [:show, :edit, :update, :destroy]
    skip_before_filter :verify_authenticity_token
    
    
    #SWAGGER Api Doc
    swagger_api_root :events do
    key :swaggerVersion, '1.2'
    key :apiVersion, '1.0.0'
    key :basePath, 'http://localhost:3000/'
    key :resourcePath, '/events'
    api do
    key :path, '/events/{eventId}'
    operation do
    key :method, 'GET'
    key :summary, 'Find event by ID'
    key :notes, 'Returns a event based on ID'
    key :type, :Event
    key :nickname, :getEventById
    items do
    key :'$ref', :Event
end
key :produces, [
'application/json',
'application/xml',
]
key :consumes, [
'application/json',
'application/xml',
]
parameter do
    key :paramType, :path
    key :name, :eventId
    key :description, 'ID of event that needs to be fetched'
    key :required, true
    key :type, :integer
end
response_message do
    key :code, 400
    key :message, 'Invalid ID supplied'
end
response_message do
    key :code, 404
    key :message, 'Event not found'
end
end
end
end

swagger_api_root :events do
    api do
        key :path, '/events'
        operation do
            key :method, 'GET'
            key :summary, 'Get events'
            key :notes, 'Returns all events'
            key :type, :Event
            key :nickname, :getEvents
            items do
                key :'$ref', :Event
            end
            key :produces, [
            'application/json',
            'application/xml',
            ]
            key :consumes, [
            'application/json',
            'application/xml',
            ]
            response_message do
                key :code, 400
                key :message, 'Invalid ID supplied'
            end
            response_message do
                key :code, 404
                key :message, 'Event not found'
            end
        end
    end
end

swagger_api_root :events do
    api do
        key :path, '/events'
        operation do
            key :method, 'POST'
            key :summary, 'Find event by ID'
            key :notes, 'Returns a event based on ID'
            key :type, :Event
            key :nickname, :postEvent
            items do
                key :'$ref', :Event
            end
            key :produces, [
            'application/json',
            'application/xml',
            ]
            key :consumes, [
            'application/json',
            'application/xml',
            ]
            parameter do
                key :paramType, :body
                key :name, :body
                key :description, 'Event object that needs to be added'
                key :required, false
                key :type, :Event
            end
            response_message do
                key :code, 400
                key :message, 'Invalid ID supplied'
            end
            response_message do
                key :code, 404
                key :message, 'Event not found'
            end
        end
    end
end
swagger_api_root :events do
    api do
        key :path, '/events/{eventId}'
        operation do
            key :method, 'PUT'
            key :summary, 'Update a Event'
            key :notes, 'Returns a event based on ID'
            key :type, :Event
            key :nickname, :postEvent
            items do
                key :'$ref', :Event
            end
            key :produces, [
            'application/json',
            'application/xml',
            ]
            key :consumes, [
            'application/json',
            'application/xml',
            ]
            parameter do
                key :paramType, :path
                key :name, :eventId
                key :description, 'ID of event that needs to be updated'
                key :required, true
                key :type, :integer
            end
            parameter do
                key :paramType, :body
                key :name, :body
                key :description, 'Event object that needs to be added'
                key :required, false
                key :type, :Event
            end
            response_message do
                key :code, 400
                key :message, 'Invalid ID supplied'
            end
            response_message do
                key :code, 404
                key :message, 'Event not found'
            end
        end
    end
end

swagger_api_root :events do
    api do
        key :path, '/events/{eventId}'
        operation do
            key :method, 'DELETE'
            key :summary, 'Delete a Event'
            key :notes, 'Delete a event based on ID'
            key :nickname, :deleteEvent
            key :consumes, [
            'application/json',
            'application/xml',
            ]
            parameter do
                key :paramType, :path
                key :name, :eventId
                key :description, 'ID of Event that needs to be deleted'
                key :required, true
                key :type, :integer
            end
            response_message do
                key :code, 400
                key :message, 'Invalid ID supplied'
            end
            response_message do
                key :code, 404
                key :message, 'Event not found'
            end
        end
    end
end

swagger_api_root :events do
    api do
        key :path, '/events/{year}{month}{day}'
        operation do
            key :method, 'GET'
            key :summary, 'Get Events within the date '
            key :notes, 'Returns all events based on denoted year, month and optional day'
            key :type, :Event
            key :nickname, :filterEventDate
            items do
                key :'$ref', :Event
            end
            key :produces, [
            'application/json',
            'application/xml',
            ]
            key :consumes, [
            'application/json',
            'application/xml',
            ]
            parameter do
                key :paramType, :path
                key :name, :year
                key :description, 'Year'
                key :required, true
                key :type, :integer
            end
            parameter do
                key :paramType, :path
                key :name, :year
                key :description, 'Month'
                key :required, true
                key :type, :string
            end
            parameter do
                key :paramType, :path
                key :name, :day
                key :description, 'Day'
                key :required, false
                key :type, :string
            end
            response_message do
                key :code, 400
                key :message, 'Invalid ID supplied'
            end
            response_message do
                key :code, 404
                key :message, 'Event not found'
            end
        end
    end
end

    
    
    # GET /events.xml
    # GET /events.json
    #include von themes umd die Themen des Events auch gleich mit zu zeigen
    def index
        @events = Event.all
        
        #Falls ein Aufruf wie z.B. location/id/events geschieht, werden die Events nach der Ressource gefiltert
        if(params[:location_id] || params[:organizer_id] || params[:theme_id])
            @events =Event.filterEventsRessource(params)
        end
        
        respond_to do |format|
            #format.html
            format.json { render :json => @events, :include =>[:themes] }
            format.xml { render :xml => @events, :include =>[:themes] }
        end
    end
    #
    # GET /events/1.xml
    # GET /events/1.json
    def show
        respond_to do |format|
            #format.html
            format.json { render :json => @event, :include =>[:themes] }
            format.xml { render :xml => @event, :include =>[:themes] }
        end
    end
    
    #Benutzt die Methode filterEventsPeriod um nach dem Zeitraum zu filtern
    def dateFilter
        month = (params[:month] || Time.zone.now.month).to_i
        year = (params[:year] || Time.zone.now.year).to_i
        day = (params[:day] || nil).to_i
        
        @events = Event.filterEventsPeriod(year, month, day)
        if @events.length >0
            respond_to do |format|
                #format.html
                format.json { render :json => @events, :include =>[:themes], status: 200}
                format.xml { render :xml => @events, :include =>[:themes], status: 200 }
            end
            else
            respond_to do |format|
                #format.html
                format.json { render json: { error: "Keine Veranstaltungen in dem Zeitraum gefunden" }, status: 200}
                format.xml { render xml: { error: "Keine Veranstaltungen in dem Zeitraum gefunden" }, status: 200 }
            end
        end
    end
    
    # GET /events/new
    def new
        @event = Event.new
    end
    
    # GET /events/1/edit
    def edit
    end
    
    # POST /events.xml
    # POST /events.json
    def create
        @event = Event.new(event_params)
        
        #Falls Themen mit gepostet wurden, werden diese dem Event hinzugefügt
        if(params[:event][:themes])
            params[:event][:themes].each do |t|
                @event.themes << Theme.find(t[:id])
            end
        end
        
        respond_to do |format|
            if @event.save
                #format.html { redirect_to @event, notice: 'Event was successfully created.' }
                format.json { render json: @event, :include =>[:themes], status: :created, location: @event }
                format.xml { render xml: @event, :include =>[:themes], status: :created, location: @event }
                else
                #format.html { render :new }
                format.json { render json: @event.errors, status: :unprocessable_entity }
                format.xml { render xml: @event.errors, status: :unprocessable_entity }
            end
        end
    end
    
    # PATCH/PUT /events/1.xml
    # PATCH/PUT /events/1.json
    def update
        respond_to do |format|
            if @event.update(event_params)
                if(params[:event][:themes])
                    params[:event][:themes].each do |t|
                        if(!@event.themes.include?(Theme.find(t[:id])))
                            @event.themes << Theme.find(t[:id])
                        end
                    end
                end
                #format.html { redirect_to @event, notice: 'Event was successfully updated.' }
                format.json { render json: @event, :include =>[:themes], status: :ok, location: @event }
                format.xml { render xml: @event, :include =>[:themes], status: :ok }
                else
                #format.html { render :edit }
                format.json { render json: @event.errors, status: :unprocessable_entity }
                format.xml { render xml: @event.errors, status: :unprocessable_entity }
            end
        end
    end
    
    # DELETE /events/1.xml
    # DELETE /events/1.json
    def destroy
        @event.destroy
        respond_to do |format|
            # if @event.delete(event_params)
            #format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
            format.json { head :no_content }
            format.xml { head :no_content, status: :ok }
            # end
        end
    end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
        #render xml: { error: "#{params}" }, status: 200
        params.require(:event).permit(:title, :description, :link, :location_id, :organizer_id, :start_time, :end_time, :themes_attributes => [:id, :name])
    end
end
