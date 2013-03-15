Kmedia::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  devise_for :users
  devise_scope :user do
    get '/login' => 'devise/sessions#new'
  end
  resources :users

  #resources :lessons, :only => [:index, :show] -- for RSS

  resources :searches
  resources :ui, :only => [:index, :show] do
    collection do
      get 'homepage'
    end
    member do
      get 'homepage_show'
    end
  end

  namespace(:admin) {
    root :to => "searches#index"

    resources :virtual_lessons

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

    resources :selected_catalogs, only: [:index, :new] do
      collection do
        post 'set_selected'
        get 'autocomplete'
      end
      member do
        delete 'unset_selected'
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
      collection do
        get :existing_suids
        get "labels/existing_suids", to: "labels#existing_suids"
        get "labels/assignable", to: "labels#assignable"
      end
      resources :labels
    end

    namespace :api do
      resources :tokens, :only => [:create, :destroy]
      resources :api, :only => [] do
        collection do
          post :register_file, :get_file_servers
          post :content_types, :file_types, :catalogs, :languages, :file_ids
        end
        member do
        end
      end
    end
  }

  root :to => "ui#homepage"
end
