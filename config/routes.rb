Rails.application.routes.draw do

  
  #Routes to both landing pages of offerings
  get 'offerings/index'
  get 'offerings/view', to: 'offerings#view'
	

  # Routes to the docview and all actions
  get 'documents/docview', to: 'documents#docview'
  get 'documents/all', to: 'documents#all'
  
  # Routes to document update action
  patch 'documents/update', to: 'documents#update'
  put 'documents/update', to: 'documents#update'
	patch 'documents/update_status', to: 'documents#update_status'
	put 'documents/update_status', to: 'documents#update_status'

  # Sends params to the docview action
  get '/documents/:id', to: 'documents#docview'

  root 'sessions#new'
  get 'browse/index', to: 'documents#index'
  get 'master_matrices/index'
  get 'master_matrices/delete'

	resources :abet_metrics, only: [:create, :destroy]
  resources :documents, only: [:create, :destroy, :edit, :new, :show, :update]
  resources :course_track_lists
  resources :libraries
  resources :approvers
  resources :master_matrices
  resources :sys_admin, only: [:index]
  resources :abet_outcomes
  resources :documents
  resources :degrees
  resources :tracks
  resources :courses
  resources :users
  resources :teachings
  resources :offerings, only: [:create, :destroy, :edit, :new, :show, :update]
  resources :pies
  resources :airs
  resources :eocms
	
	# Functionality for evaluation in Tracker (offering index view)
	put 'offerings/evaluation/:id', to: 'offerings#evaluation'
	put 'abet_metrics/evaluation/:id', to: 'abet_metrics#evaluation'

  get '/login', to: 'sessions#new'
	post '/login', to: 'sessions#create'
	delete '/logout', to: 'sessions#destroy'

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
