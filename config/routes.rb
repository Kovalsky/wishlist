Wishlist::Application.routes.draw do

  resources :wishes

  get "profile/edit"

  match '/friends', :to => 'friends#index'
  match '/friends/:id', :to => 'friends#show', :as => 'friend'
  match '/home',  :to => 'landing#home_page'
  match '/auth/vkontakte/callback', :to => 'landing#login'
  match '/logout', :to => 'landing#logout'
  match '/friends_whose_birthday_is_in_one_week', :to => 'friends#bdate_in_1_week', :as => 'friends_one_week'
  match '/friends_whose_birthday_is_in_two_weeks', :to => 'friends#bdate_in_2_weeks', :as => 'friends_two_weeks'
  match '/friends_whose_birthday_is_in_one_month', :to => 'friends#bdate_in_1_month', :as => 'friends_one_month'
  match '/friends_whose_birthday_is_unknown', :to => 'friends#bdate_unknown', :as => 'friends_unknown'
  match '/search', :to => 'wishes#search', :as => 'search'
  match '/new', :to => 'wishes#new'
  match '/reserve', :to => 'reserve#index', :as => 'reserve_index'
  match '/reserve/:id/add', :to => 'reserve#add_reserve', :as => 'add_reserve'
  match '/reserve/:id/delete', :to => 'reserve#delete_reserve', :as => 'delete_reserve'
  match '/local_login', :to => 'landing#local_login', :as => 'local_login'
  match '/local_login/:id', :to => 'landing#local_login_as', :as => 'local_user'

  root :to => 'landing#home_page'
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
