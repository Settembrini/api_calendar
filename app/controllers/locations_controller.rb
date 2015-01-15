class LocationsController < ApplicationController
    before_action :set_location, only: [:show, :edit, :update, :destroy]
    skip_before_filter :verify_authenticity_token
    
    #SWAGGER Api Doc
    swagger_api_root :locations do
        key :swaggerVersion, '1.2'
        key :apiVersion, '1.0.0'
        key :basePath, 'http://localhost:3000/'
        key :resourcePath, '/locations'
        api do
            key :path, '/locations/{locationId}'
            operation do
                key :method, 'GET'
                key :summary, 'Find location by ID'
                key :notes, 'Returns a location based on ID'
                key :type, :Location
                key :nickname, :getLocationById
                items do
                    key :'$ref', :Location
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
                    key :name, :locationId
                    key :description, 'ID of location that needs to be fetched'
                    key :required, true
                    key :type, :integer
                end
                response_message do
                    key :code, 400
                    key :message, 'Invalid ID supplied'
                end
                response_message do
                    key :code, 404
                    key :message, 'Location not found'
                end
                response_message do
                    key :code, 200
                    key :responseModel, :Location
                end
            end
        end
    end

swagger_api_root :locations do
    api do
        key :path, '/locations'
        operation do
            key :method, 'GET'
            key :summary, 'Get locations'
            key :notes, 'Returns all locations'
            key :type, :Location
            key :nickname, :getLocations
            items do
                key :'$ref', :Location
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
                key :message, 'Location not found'
            end
        end
    end
end

swagger_api_root :locations do
    api do
        key :path, '/locations'
        operation do
            key :method, 'POST'
            key :summary, 'Find location by ID'
            key :notes, 'Returns a location based on ID'
            key :type, :Location
            key :nickname, :postLocation
            items do
                key :'$ref', :Location
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
                key :description, 'Location object that needs to be added'
                key :required, false
                key :type, :Location
            end
            response_message do
                key :code, 400
                key :message, 'Invalid ID supplied'
            end
            response_message do
                key :code, 404
                key :message, 'Location not found'
            end
        end
    end
end
swagger_api_root :locations do
    api do
        key :path, '/locations/{locationId}'
        operation do
            key :method, 'PUT'
            key :summary, 'Update a Location'
            key :notes, 'Returns a location based on ID'
            key :type, :Location
            key :nickname, :postLocation
            items do
                key :'$ref', :Location
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
                key :name, :locationId
                key :description, 'ID of location that needs to be updated'
                key :required, true
                key :type, :integer
            end
            parameter do
                key :paramType, :body
                key :name, :body
                key :description, 'Location object that needs to be added'
                key :required, false
                key :type, :Location
            end
            response_message do
                key :code, 400
                key :message, 'Invalid ID supplied'
            end
            response_message do
                key :code, 404
                key :message, 'Location not found'
            end
        end
    end
end

swagger_api_root :locations do
    api do
        key :path, '/locations/{locationId}'
        operation do
            key :method, 'DELETE'
            key :summary, 'Delete a Location'
            key :notes, 'Delete a location based on ID'
            key :nickname, :deleteLocation
            key :consumes, [
            'application/json',
            'application/xml',
            ]
            parameter do
                key :paramType, :path
                key :name, :locationId
                key :description, 'ID of location that needs to be deleted'
                key :required, true
                key :type, :integer
            end
            response_message do
                key :code, 400
                key :message, 'Invalid ID supplied'
            end
            response_message do
                key :code, 404
                key :message, 'Location not found'
            end
        end
    end
end


    # GET /locations
    # GET /locations.json
    def index
        @locations = Location.all
        respond_to do |format|
            #format.html
            format.json { render json: @locations }
            format.xml { render xml: @locations }
        end
    end
    
    # GET /locations/1
    # GET /locations/1.json
    def show
        respond_to do |format|
            #format.html
            format.json { render json: @location }
            format.xml { render xml: @location }
        end
    end
    
    # GET /locations/new
    def new
        @location = Location.new
    end
    
    # GET /locations/1/edit
    def edit
    end
    
    # POST /locations
    # POST /locations.json
    def create
        @location = Location.new(location_params)
        
        respond_to do |format|
            if @location.save
                #format.html { redirect_to @location, notice: 'Location was successfully created.' }
                format.json { render json: @location, status: :created, location: @location }
                format.xml { render xml: @location, status: :created }
                else
                #format.html { render :new }
                format.json { render json: @location.errors, status: :unprocessable_entity }
                format.xml { render xml: @location.errors, status: :unprocessable_entity }
            end
        end
    end
    
    # PATCH/PUT /locations/1
    # PATCH/PUT /locations/1.json
    def update
        respond_to do |format|
            if @location.update(location_params)
                #format.html { redirect_to @location, notice: 'Location was successfully updated.' }
                format.json { render json: @location, status: :ok, location: @location }
                format.xml { render xml: @location, status: :ok, location: @location }
                else
                #format.html { render :edit }
                format.json { render json: @location.errors, status: :unprocessable_entity }
                format.xml { render xml: @location.errors, status: :unprocessable_entity }
            end
        end
    end
    
    # DELETE /locations/1
    # DELETE /locations/1.json
    def destroy
        @location.destroy
        respond_to do |format|
            #format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
            format.json { head :no_content }
            format.xml { head :no_content }
            
        end
    end
    
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
        @location = Location.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
        params.require(:location).permit(:name, :link, :street, :district, :city, :zip)
    end
end
