Rails.application.routes.draw do
    
    root 'events#index', defaults: { format: 'xml' }
    
    resources :events, defaults: { format: 'xml' }
    
    
    #SWAGGER-UI
    get '/api' => redirect('/swagger/dist/index?url=/apidocs')
    resources :apidocs, only: [:index, :show]
    
    
    #Nested Ressources z.B. /themes/1/events
    resources :themes, :locations, :organizers , defaults: { format: 'xml' } do
        resources :events, only: [:index],  defaults: { format: 'xml' }
        #get 'search' , on: :collection
    end
    
    #Nur um Theme aus Event zu löschen
    resources :events do
        resources :themes, only: [:destroy]
    end
    
    
    
    #Überprüft ob das Datum richtig ist. Z.B.: Kein 31.02.2014
    class ValidDateConstraint
    def matches?(request)
    begin
        if(request.params[:day])
            Date.parse("#{request.params[:day]}.#{request.params[:month]}.#{request.params[:year]}")
            else
            Date.parse("01.#{request.params[:month]}.#{request.params[:year]}")
        end
        true
        rescue
        false
    end
end
end

#Rout auf Filter nach datum
get '/events/:year/:month(/:day)' => 'events#dateFilter', constraints: {
    year:       /\d{4}/,
    month:      /\d{1,2}/,
    day:        /\d{1,2}/
}, constraints: ValidDateConstraint.new

#Rout auf WADL
get '/wadl', :to => redirect('/api_calendar.wadl')

#Error für nicht vorhanden Path
match '*path', :to => 'application#routing_error', via: :all, defaults: { format: 'xml' }
#put '*path', :to => 'application#routing_error', defaults: { format: 'xml' }

# The priority is based upon order of creation: first created -> highest priority.
# See how all your routes lay out with "rake routes".

# You can have the root of your site routed with "root"
# root 'welcome#index'

# Example of regular route:
#   get 'products/:id' => 'catalog#view'

# Example of named route that can be invoked with purchase_url(id: product.id)
#   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

# Example resource route (maps HTTP verbs to controller actions automatically):
#   resources :products

# Example resource route with options:
#   resources :products do
#     member do
#       get 'short'
#       post 'toggle'
#     end
#
#     collection do
#       get 'sold'
#     end
#   end

# Example resource route with sub-resources:
#   resources :products do
#     resources :comments, :sales
#     resource :seller
#   end

# Example resource route with more complex sub-resources:
#   resources :products do
#     resources :comments
#     resources :sales do
#       get 'recent', on: :collection
#     end
#   end

# Example resource route with concerns:
#   concern :toggleable do
#     post 'toggle'
#   end
#   resources :posts, concerns: :toggleable
#   resources :photos, concerns: :toggleable

# Example resource route within a namespace:
#   namespace :admin do
#     # Directs /admin/products/* to Admin::ProductsController
#     # (app/controllers/admin/products_controller.rb)
#     resources :products
#   end
end
