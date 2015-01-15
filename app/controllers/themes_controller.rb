class ThemesController < ApplicationController
  before_action :set_theme, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token

#SWAGGER Api Doc
swagger_api_root :themes do
key :swaggerVersion, '1.2'
key :apiVersion, '1.0.0'
key :basePath, 'http://localhost:3000/'
key :resourcePath, '/themes'
api do
key :path, '/themes/{themeId}'
operation do
key :method, 'GET'
key :summary, 'Find theme by ID'
key :notes, 'Returns a theme based on ID'
key :type, :Theme
key :nickname, :getThemeById
items do
key :'$ref', :Theme
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
    key :name, :themeId
    key :description, 'ID of theme that needs to be fetched'
    key :required, true
    key :type, :integer
end
response_message do
    key :code, 400
    key :message, 'Invalid ID supplied'
end
response_message do
    key :code, 404
    key :message, 'Theme not found'
end
end
end
end

swagger_api_root :themes do
    api do
        key :path, '/themes'
        operation do
            key :method, 'GET'
            key :summary, 'Get themes'
            key :notes, 'Returns all themes'
            key :type, :array
            key :nickname, :getThemes
            items do
                key :'$ref', :Theme
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
                key :message, 'Theme not found'
            end
        end
    end
end

swagger_api_root :themes do
    api do
        key :path, '/themes'
        operation do
            key :method, 'POST'
            key :summary, 'Find theme by ID'
            key :notes, 'Returns a theme based on ID'
            key :type, :Theme
            key :nickname, :postTheme
            items do
                key :'$ref', :Theme
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
                key :description, 'Theme object that needs to be added'
                key :required, false
                key :type, :Theme
            end
            response_message do
                key :code, 400
                key :message, 'Invalid ID supplied'
            end
            response_message do
                key :code, 404
                key :message, 'Theme not found'
            end
        end
    end
end
swagger_api_root :themes do
    api do
        key :path, '/themes/{themeId}'
        operation do
            key :method, 'PUT'
            key :summary, 'Update a Theme'
            key :notes, 'Returns a theme based on ID'
            key :type, :Theme
            key :nickname, :postTheme
            items do
                key :'$ref', :Theme
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
                key :name, :themeId
                key :description, 'ID of theme that needs to be updated'
                key :required, true
                key :type, :integer
            end
            parameter do
                key :paramType, :body
                key :name, :body
                key :description, 'Theme object that needs to be added'
                key :required, false
                key :type, :Theme
            end
            response_message do
                key :code, 400
                key :message, 'Invalid ID supplied'
            end
            response_message do
                key :code, 404
                key :message, 'Theme not found'
            end
        end
    end
end

swagger_api_root :themes do
    api do
        key :path, '/themes/{themeId}'
        operation do
            key :method, 'DELETE'
            key :summary, 'Delete a Theme'
            key :notes, 'Delete a theme based on ID'
            key :nickname, :deleteTheme
            key :consumes, [
            'application/json',
            'application/xml',
            ]
            parameter do
                key :paramType, :path
                key :name, :themeId
                key :description, 'ID of Theme that needs to be deleted'
                key :required, true
                key :type, :integer
            end
            response_message do
                key :code, 400
                key :message, 'Invalid ID supplied'
            end
            response_message do
                key :code, 404
                key :message, 'Theme not found'
            end
        end
    end
end



  # GET /themes
  # GET /themes.json
  def index
    @themes = Theme.all
    respond_to do |format|
        #format.html
        format.json { render json: @themes }
        format.xml { render xml: @themes }
    end
  end

  # GET /themes/1
  # GET /themes/1.json
  def show
      respond_to do |format|
          #format.html
          format.json { render json: @theme }
          format.xml { render xml: @theme }
      end
  end

  # GET /themes/new
  def new
    @theme = Theme.new
  end

  # GET /themes/1/edit
  def edit
  end

  # POST /themes
  # POST /themes.json
  def create
    @theme = Theme.new(theme_params)

    respond_to do |format|
      if @theme.save
          #format.html { redirect_to @theme, notice: 'Theme was successfully created.' }
        format.json { render json: @theme, status: :created, location: @theme }
        format.xml { render xml: @theme, status: :created, location: @theme }
      else
      #format.html { render :new }
        format.json { render json: @theme.errors, status: :unprocessable_entity }
        format.xml { render xml: @theme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /themes/1
  # PATCH/PUT /themes/1.json
  def update
    respond_to do |format|
      if @theme.update(theme_params)
          #format.html { redirect_to @theme, notice: 'Theme was successfully updated.' }
        format.json { render json: @theme, status: :ok, location: @theme }
        format.xml { render xml: @theme, status: :ok, location: @theme }
      else
      #format.html { render :edit }
        format.json { render json: @theme.errors, status: :unprocessable_entity }
        format.xml { render xml: @theme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /themes/1
  # DELETE /themes/1.json
  def destroy
      if(params[:event_id])
          @event = Event.find(params[:event_id])
          t = Theme.find(params[:id])
          @event.themes.delete(t)
          respond_to do |format|
              #format.html { redirect_to themes_url, notice: 'Theme was successfully destroyed.' }
              format.json { render :json => @event, :include =>[:themes] }
              format.xml { render :xml => @event, :include =>[:themes] }
          end
      else
        @theme.destroy
        respond_to do |format|
            #format.html { redirect_to themes_url, notice: 'Theme was successfully destroyed.' }
            format.json { head :no_content }
            format.xml { head :no_content }
        end
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_theme
      @theme = Theme.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def theme_params
      params.require(:theme).permit(:name)
    end
end
