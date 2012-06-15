Kmedia::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  devise_for :users
  resources :users
  resources :searches
  resources :ui

  resources :catalogs, :only => :index do
    post :index, :on => :collection
  end

  resources :content_types, :only => :index do
    post :index, :on => :collection
  end

  resources :file_types, :only => :index do
    post :index, :on => :collection
  end

  resources :languages, :only => :index do
    post :index, :on => :collection
  end

  namespace(:admin) {
    root :to => "searches#index"

    resources :lessons do
      member do
        get 'parse_lesson_name'
        get 'edit_long_descr'
        get 'edit_transcript'
        get 'mark_for_merge'
        put 'update_long_descr'
        put 'update_transcript'
        get 'merge_get_list'
        post 'merge'
      end
      collection do
        get 'parse_new_lesson_name'
      end
      resources :catalogs do
        member do
          get 'batch'
        end
      end
    end

    resources :file_assets
    resources :catalogs
    resources :departments
    resources :users do
      member do
        get :become
      end
    end
    resources :lessondesc_patterns
    resources :searches
    resources :dictionaries do
      resources :labels
    end

    namespace :api do
      resources :tokens, :only => [:create, :destroy]
      resources :api, :only => [] do
        collection do
          post :register_file, :get_file_servers
        end
      end
    end
  }

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
  # root :to => "welcome#index"
  root :to => "ui#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
