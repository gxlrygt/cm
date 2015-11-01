Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  get "loan_programs" => "loan_programs#index"
  namespace :loan_programs do
    get "conventional"
    get "arms"
    get "harp"
    get "government"
  end

  get "about" => "about#index"
  namespace :about do
    get "team"    
    get "latest_news"
    get "join_us"
    get "contact_us"
  end

  get "broker_center" => "broker_center#index"
  namespace :broker_center do
    get "quick_pricer"
    get "resources"
    get "appraisals"
    post "appraisals_signup_request"
  end

  get "quick_pricer" => "quick_pricer#index"
  post "quick_pricer/search" => "quick_pricer#search"

  post "leads" => "leads#create"
  post "attempt_tpo_login" => "tpo#attempt_login"

  resources :broker_approval_forms do
    member do
      get :mortgage_broker_agreement
      get :loan_fraud
      get :fair_lending_acknowledgement
      get :company_resolution_doc_3
      get :company_resolution_doc_4
      get :fha_sponsorship
      get :quality_control
      get :respa
      get :sales_compensation
      get :va_sponsorship
    end
  end

  resources :loans do
    member do
      get :cover_page
    end
  end

  resources :products, only: [:index, :show]
  resources :contact_forms, only: [:create, :show]

  namespace :users, as: "user" do
    resource :settings, only: [:edit, :update]
  end

  resources :states, only: [:index] do
    member do
      get :counties
    end
  end

  get "sso" => "sso#index"

  # You can have the root of your site routed with "root"
  root 'welcome#index'

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
