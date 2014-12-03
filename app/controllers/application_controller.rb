class ApplicationController < ActionController::Base
    respond_to :xml, :json
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :null_session
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    skip_before_filter :verify_authenticity_token
    
    def not_found
        #respond_to do |format|
        #format.xml { render xml: "Ressource with id: '#{params[:id]}' not found", status: :not_found}
        if(params[:id])
            render xml: { error: "#{params[:controller]} with id: '#{params[:id]}' not found" }, status: 404
            else
            render xml: { error: "Theme not found" }, status: 404
        end
        #render xml: { error: "#error" }, status: 404
    end
    rescue_from(ActionController::UnknownFormat) do |e|
    render xml: { error: "Unknown Format. Controller: '#{params[:controller]}' don't support Format: '#{params[:format]}'"}, status: 406
    end

    
    def routing_error(error = 'Routing error', status = :not_found, exception=nil)
        respond_to do |format|
            # if @event.delete(event_params)
            #format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
            format.json { render json: { error: "Routing error. Path '/#{params[:path]}' not found"}, status: 404 }
            format.xml { render xml: { error: "Routing error. Path '/#{params[:path]}' not found"}, status: 404}
            # end
        end
    end
end
