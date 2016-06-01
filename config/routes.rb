Rails.application.routes.draw do
  get '/login' => 'session#new', :as => 'login'
    post '/login' => 'session#create'
    delete '/login' => 'session#destroy', :as => 'logout'

    delete 'delete_image' => 'images#destroy', :as => 'delete_image'
    delete '/users_groups' => 'users_groups#destroy', :as  =>'leave_group'

    get '/admin_page' => 'groups#admin', :as => 'admin_page'

    post '/change_member' => 'groups#member_change', :as => 'member_change'

  resources :users_groups, :only => [:new, :create]
  resources :images, :only => [:new, :show, :create, :edit, :update]

resources :groups, :only => [:new, :show, :create, :index, :edit, :update]
resources :users, :only => [:new, :create, :index, :edit, :update]
  root 'welcome#index', :as => 'home'
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
