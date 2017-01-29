#   Barnabas Bulpett
#   WEB-289-YD1
#   Spring 2015
#   routes.rb
#   This is where all the app's routes are defined

Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations" }

  devise_scope :user do
    # authentication
    post "/accounts/adminview" => "devise/sessions#new"

    # get '/signin', to: 'devise/sessions#new', as: 'new_user_session'
    # post '/signin', to: 'devise/sessions#create', as: 'user_session'
    # get '/signout', to: 'devise/sessions#destroy'
    # delete '/signout', to: 'devise/sessions#destroy', as: 'destroy_user_session'

    # registrations
    # get '/register', to: 'users/registrations#new', as: 'new_user_registration'
    # post '/register', to: 'users/registrations#create', as: 'user_registration'
  end

  root 'home#index'

  get 'home/about'
  get 'home/help'
  get 'home/legal'

  get 'accounts/add_account', to: 'accounts#new'
  post 'accounts/add_account', to: 'accounts#create'

  resources :administrators do
    member do
      get :adminview
      get :manage_accounts
      get :manage_customers
      get :manage_acct_transactions

    end
  end

  resources :users do
    resource :customers
    resource :accounts
    resource :addresses
  end

  resources :accounts do
    resource :acct_transactions
    resource :wire_transfers
  end

  resources :customers do
   resources :addresses, :accounts
  end

  resources :account_types, :accounts, :addresses, :administrators, :customers, :transaction_types, :acct_transactions, :users, :recipient_details

# The priority is based upon order of creation: first created -> highest priority.
# See how all your routes lay out with "rake routes".
# You can have the root of your site routed with "root"
# Example resource route with options:
# Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  # Another example
  #   get '/about' => 'home#about'
  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase
  # Example resource route (maps HTTP verbs to controller actions automatically):
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
