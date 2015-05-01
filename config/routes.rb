require 'sidekiq/web'

Rails.application.routes.draw do
  use_doorkeeper do
    controllers :applications => 'oauth/applications'
  end
  devise_for :users
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
  
  # Characters
  resources :characters, only: ['show'] do
    collection do
      get 'import' => 'characters#import', as: 'import'
      post 'import' => 'characters#redirect_to_verify', as: 'redirect_to_verify'
      get 'import/:lodestone_id' => 'characters#unverified', as: 'unverified'
      get 'import/:lodestone_id/verify' => 'characters#verify', as: 'verify'
    end
  end
  
  # Groups
  resources :groups do
    member do
      post 'members' => 'groups#add', as: 'add_to'
      delete 'members/:lodestone_id' => 'groups#remove', as: 'remove_from'
      
      resources :events, path: '', except: [:index, :show]
    end
  end
  
  # DATABASE DATABASE, JUST LIVING IN THE DATABASE
  resources :items, only: [:index, :show]
  
  # And search for everything in one place
  get 'search' => 'search#index'
  
  # Admin UI
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  # API Documentation
  # get '/api' => 'api_docs#show'
  
  # REST API
  mount API::Root => '/api'
  get '/api' => redirect('/api/swagger')
  
  # Sidekiq monitoring
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

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
