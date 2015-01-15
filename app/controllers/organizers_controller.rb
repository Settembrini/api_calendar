class OrganizersController < ApplicationController
  before_action :set_organizer, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token


#SWAGGER Api Doc
swagger_api_root :organizers do
key :swaggerVersion, '1.2'
key :apiVersion, '1.0.0'
key :basePath, 'http://localhost:3000/'
key :resourcePath, '/organizers'
api do
key :path, '/organizers/{organizerId}'
operation do
key :method, 'GET'
key :summary, 'Find organizer by ID'
key :notes, 'Returns a organizer based on ID'
key :type, :Organizer
key :nickname, :getOrganizerById
items do
key :'$ref', :Organizer
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
    key :name, :organizerId
    key :description, 'ID of organizer that needs to be fetched'
    key :required, true
    key :type, :integer
end
response_message do
    key :code, 400
    key :message, 'Invalid ID supplied'
end
response_message do
    key :code, 404
    key :message, 'Organizer not found'
end
end
end
end

swagger_api_root :organizers do
    api do
        key :path, '/organizers'
        operation do
            key :method, 'GET'
            key :summary, 'Get organizers'
            key :notes, 'Returns all organizers'
            key :type, :Organizer
            key :nickname, :getOrganizers
            items do
                key :'$ref', :Organizer
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
                key :message, 'Organizer not found'
            end
        end
    end
end

swagger_api_root :organizers do
    api do
        key :path, '/organizers'
        operation do
            key :method, 'POST'
            key :summary, 'Find organizer by ID'
            key :notes, 'Returns a organizer based on ID'
            key :type, :Organizer
            key :nickname, :postOrganizer
            items do
                key :'$ref', :Organizer
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
                key :description, 'Organizer object that needs to be added'
                key :required, false
                key :type, :Organizer
            end
            response_message do
                key :code, 400
                key :message, 'Invalid ID supplied'
            end
            response_message do
                key :code, 404
                key :message, 'Organizer not found'
            end
        end
    end
end
swagger_api_root :organizers do
    api do
        key :path, '/organizers/{organizerId}'
        operation do
            key :method, 'PUT'
            key :summary, 'Update a Organizer'
            key :notes, 'Returns a organizer based on ID'
            key :type, :Organizer
            key :nickname, :postOrganizer
            items do
                key :'$ref', :Organizer
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
                key :name, :organizerId
                key :description, 'ID of organizer that needs to be updated'
                key :required, true
                key :type, :integer
            end
            parameter do
                key :paramType, :body
                key :name, :body
                key :description, 'Organizer object that needs to be added'
                key :required, false
                key :type, :Organizer
            end
            response_message do
                key :code, 400
                key :message, 'Invalid ID supplied'
            end
            response_message do
                key :code, 404
                key :message, 'Organizer not found'
            end
        end
    end
end

swagger_api_root :organizers do
    api do
        key :path, '/organizers/{organizerId}'
        operation do
            key :method, 'DELETE'
            key :summary, 'Delete a Organizer'
            key :notes, 'Delete a organizer based on ID'
            key :nickname, :deleteOrganizer
            key :consumes, [
            'application/json',
            'application/xml',
            ]
            parameter do
                key :paramType, :path
                key :name, :organizerId
                key :description, 'ID of Organizer that needs to be deleted'
                key :required, true
                key :type, :integer
            end
            response_message do
                key :code, 400
                key :message, 'Invalid ID supplied'
            end
            response_message do
                key :code, 404
                key :message, 'Organizer not found'
            end
        end
    end
end

swagger_api_root :organizers do
    api do
        key :path, '/organizers/{organizerId}/events'
        operation do
            key :method, 'GET'
            key :summary, 'Get all Events in the Organizer'
            key :notes, 'Get all Events on a organizer based on ID'
            key :type, :array
            key :nickname, :getOrganizerEvents
            items do
                key :'$ref', :Event
            end
            key :consumes, [
            'application/json',
            'application/xml',
            ]
            parameter do
                key :paramType, :path
                key :name, :organizerId
                key :description, 'ID of organizer'
                key :required, true
                key :type, :integer
            end
            response_message do
                key :code, 400
                key :message, 'Invalid ID supplied'
            end
            response_message do
                key :code, 404
                key :message, 'Organizer not found'
            end
        end
    end
end

  # GET /organizers.xml
  # GET /organizers.json
  def index
    @organizers = Organizer.all
    respond_to do |format|
        #format.html
        format.json { render json: @organizers }
        format.xml { render xml: @organizers }
    end
  end

  # GET /organizers/1.xml
  # GET /organizers/1.json
  def show
      respond_to do |format|
          #format.html
          format.json { render json: @organizer }
          format.xml { render xml: @organizer }
      end
  end

  # GET /organizers/new
  def new
    @organizer = Organizer.new
  end

  # GET /organizers/1/edit
  def edit
  end

  # POST /organizers.xml
  # POST /organizers.json
  def create
    @organizer = Organizer.new(organizer_params)

    respond_to do |format|
      if @organizer.save
          #format.html { redirect_to @organizer, notice: 'Organizer was successfully created.' }
        format.json { render json: @organizer, status: :created, location: @organizer }
        format.xml { render xml: @organizer, status: :created, location: @organizer }
      else
      #format.html { render :new }
        format.json { render json: @organizer.errors, status: :unprocessable_entity }
        format.xml { render xml: @organizer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizers/1.xml
  # PATCH/PUT /organizers/1.json
  def update
    respond_to do |format|
      if @organizer.update(organizer_params)
          #format.html { redirect_to @organizer, notice: 'Organizer was successfully updated.' }
        format.json { render json: @organizer, status: :ok, location: @organizer }
        format.xml { render xml: @organizer, status: :ok, location: @organizer }
      else
      #format.html { render :edit }
        format.json { render json: @organizer.errors, status: :unprocessable_entity }
        format.xml { render xml: @organizer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizers/1.xml
  # DELETE /organizers/1.json
  def destroy
    @organizer.destroy
    respond_to do |format|
        #format.html { redirect_to organizers_url, notice: 'Organizer was successfully destroyed.' }
      format.json { head :no_content }
      format.xml { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organizer
      @organizer = Organizer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organizer_params
        params.require(:organizer).permit(:name, :link)
    end
end
