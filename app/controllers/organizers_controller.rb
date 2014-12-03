class OrganizersController < ApplicationController
  before_action :set_organizer, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token

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
