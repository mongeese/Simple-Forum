ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "boards"

  # See how all your routes lay out with "rake routes"
  map.register 'register', :controller => "Sessions", :action => "register"
  map.login 'login', :controller => "Sessions", :action => "login"
  map.logout 'logout', :controller => "Sessions", :action => "logout"
  map.fp 'password', :controller => "Sessions", :action => "password"
  
  map.user_profile "users/profile/", :controller => "Users", :action => "profile"
  map.search_users "users/search/:terms/:page.:format", :controller => "users", :action => "search", :terms => "", :page => 1
  map.resources :users

  map.resources :topics, :except => :show, :member => {:reply => :post}
  map.topic "topics/:id/:page.:format", :controller => "topics", :action => "show", :page => 1
  
  map.resources :search
  map.search "search/results/:q/:page.:format", :controller => "Search", :action => "results", :page => 1
  
  map.resources :boards

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
end
