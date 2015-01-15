class ApidocsController < ActionController::Base
    include Swagger::Blocks
    swagger_root do
        key :swaggerVersion, '1.2'
        key :apiVersion, '1.0.0'
        info do
            key :title, 'Swagger Sample App'
        end
        api do
            key :path, '/locations'
            key :description, 'Operations about locations'
        end
        api do
            key :path, '/organizers'
            key :description, 'Operations about organizers'
        end
        api do
            key :path, '/themes'
            key :description, 'Operations about themes'
        end
        api do
            key :path, '/events'
            key :description, 'Operations about events'
        end
    end

# A list of all classes that have swagger_* declarations.
SWAGGERED_CLASSES = [
LocationsController,
Location,
OrganizersController,
Organizer,
ThemesController,
Theme,
EventsController,
Event,
self,
].freeze

def index
    render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
end

def show
    render json: Swagger::Blocks.build_api_json(params[:id], SWAGGERED_CLASSES)
end
end