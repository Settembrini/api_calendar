class EventsController < ApplicationController
    before_action :set_event, only: [:show, :edit, :update, :destroy]
    skip_before_filter :verify_authenticity_token
    # GET /events.xml
    # GET /events.json
    def index
        @events = Event.all
        if(params[:location_id] || params[:organizer_id] || params[:theme_id])
            #render xml: { error: "Keine Verasdfraum gefunden" }, status: 200
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
    def search
        month = (params[:month] || Time.zone.now.month).to_i
        year = (params[:year] || Time.zone.now.year).to_i
        day = (params[:day] || nil).to_i
        #render xml: { message: "Eingabe: Jahr: #{year} Monat: #{month} Tag: #{day}" }, status: 200
        @events = Event.filterEventsPeriod(year, month, day)
        if @events.length >0
            render :xml => @events, :include =>[:themes]
            else
            render xml: { error: "Keine Veranstaltungen in dem Zeitraum gefunden" }, status: 200
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
        #render xml: { error: "#{params[:event][:themes].first[:id]}" }, status: 200
        #return
        @event = Event.new(event_params)
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
                #format.html { redirect_to @event, notice: 'Event was successfully updated.' }
                format.json { render xml: @event, :include =>[:themes], status: :ok, location: @event }
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
        #params.require(:event).permit(:title, :description, :location_id, :organizer_id, :theme_id, :start_time, :end_time) if params[:event]
    end
end