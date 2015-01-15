class ApplicationController < ActionController::Base
    include Swagger::Blocks
    respond_to :xml, :json
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :null_session
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    skip_before_filter :verify_authenticity_token
    
    def not_found(error)
        respond_to do |format|
            format.json { render :json => {:error => error.message}, :status => :not_found}
            format.xml { render :xml => {:error => error.message}, :status => :not_found}
        end
    end
    
    rescue_from(ActionController::UnknownFormat) do |e|
        render xml: { error: "Unknown Format. Controller: '#{params[:controller]}' don't support Format: '#{params[:format]}'"}, status: 406
    end

    rescue_from(ActionController::ParameterMissing) do |parameter_missing_exception|
        respond_to do |format|
            format.json { render json: { error: "Action failed: #{params[:action]}. Required parameter missing: #{parameter_missing_exception.param}"}, status: 400}
            format.xml { render xml: { error: "Action failed: #{params[:action]}. Required parameter missing: #{parameter_missing_exception.param}"}, status: 400}
        end
    end

    
    def routing_error(error = 'Routing error', status = :not_found, exception=nil)
        respond_to do |format|
            format.json { render json: { error: "Routing error. Path '/#{params[:path]}' not found"}, status: 404 }
            format.xml { render xml: { error: "Routing error. Path '/#{params[:path]}' not found"}, status: 404}
        end
    end
end
