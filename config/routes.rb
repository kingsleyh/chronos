Chronos::Application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'timesheets#index'

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

  get 'users/settings' => 'users#settings', :as => :user_settings
  get 'timesheets/submit' => 'timesheets#submit', :as => :timesheet_submit
  get 'timesheets/approve' => 'timesheets#approve', :as => :timesheet_approve
  get 'timesheets/unapprove' => 'timesheets#unapprove', :as => :timesheet_unapprove
  get 'timesheets/process' => 'timesheets#process_it', :as => :timesheet_process
  get 'timesheets/reject' => 'timesheets#reject', :as => :timesheet_reject
  post 'users/update_settings' => 'users#update_settings', :as => :update_settings

  resources :customers, :projects, :tasks, :timesheets, :timerows, :users, :approvals

  get 'customers/destroy/:id' => 'customers#destroy', :as => :destroy_customer
  get 'projects/destroy/:id' => 'projects#destroy', :as => :destroy_project
  get 'tasks/destroy/:id' => 'tasks#destroy', :as => :destroy_task
  get 'timesheets/destroy/:id' => 'timesheets#destroy', :as => :destroy_timesheet
  get 'timerows/destroy/:id' => 'timerows#destroy', :as => :destroy_timerow
  get 'users/destroy/:id' => 'users#destroy', :as => :destroy_user

  post 'users/create_user' => 'users#create_user', :as => :create_user

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
