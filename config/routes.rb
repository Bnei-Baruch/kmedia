Kmedia::Application.routes.draw do

  resources :morning_lesson, only: [:show]

  scope '/(:locale)', constraints: { locale: /#{Language::UI_LANGUAGES.join('|')}/ } do

    resources :searches
    resources :feeds, only: [:index] do
      collection do
        get 'wsxml'
        get 'rss_video', format: :rss
        get 'morning_lesson', format: :rss
        get 'podcast', format: :rss
        get 'podcast1', format: :rss
        get 'rus_for_laitman_ru', format: :rss
        get 'google_mapindex'
      end
    end

    resources :books, only: [:index, :show]

    resources :ui, only: [:index, :show] do
      collection do
        get 'homepage'
        get 'google_ads'
        get 'lesson_downloader'
      end
      member do
        get 'homepage_show'
        get 'next_lesson'
        get 'prev_lesson'
      end
    end

    resources :simple, only: [:index, :show]

    resources :typing, only: [:index] do
    end

    resources :comments, only: :create

    root to: 'ui#homepage'

    mount Ckeditor::Engine => '/ckeditor'

    devise_for :users
    devise_scope :user do
      get '/login' => 'devise/sessions#new'
    end
    resources :users

    namespace(:admin) do
      root to: 'searches#index'

      resources :virtual_lessons do
        collection do
          get 'combine'
        end
        member do
          put 'reorder'
        end
      end
      resources :file_types
      resources :comments, only: [:index, :destroy]

      resources :censorship, only: [:index, :show] do
        member do
          post 'clear'
          post 'disable'
        end
      end

      resources :containers do
        member do
          get 'edit_long_descr'
          get 'edit_transcript'
          get 'mark_for_merge'
          put 'update_long_descr'
          put 'update_transcript'
          get 'merge_get_list'
          post 'merge'
          post 'send_to_censor'
        end
        collection do
          get 'get_update'
          post 'add_update'
          get 'combine'
        end
        resources :catalogs do
          member do
            get 'batch'
          end
        end
      end

      resources :selected_catalogs, only: [:index, :new, :edit, :update] do
        collection do
          get 'new_books'
          post 'set_books'
          post 'set_selected'
          get 'autocomplete'
        end
        member do
          delete 'unset_books'
          delete 'unset_selected'
        end
      end

      resources :file_assets
      resources :catalogs do
        collection do
          get :manage
          get :move_prepare
          get :move

          # required for Sortable GUI server side actions
          post :rebuild
        end
      end
      resources :departments
      resources :users do
        member do
          get :become
        end
      end
      resources :container_description_patterns
      resources :searches
      resources :dictionaries do
        collection do
          get :existing_suids
          get 'labels/existing_suids', to: 'labels#existing_suids'
          get 'labels/assignable', to: 'labels#assignable'
        end
        resources :labels
      end

      # using "post" method for the api calls because "get"  is being redirected to sign in page
      namespace :api do
        resources :tokens, only: [:create, :destroy]
        resources :api, only: [] do
          collection do
            post :register_file, :get_file_servers
            post :content_types, :file_types, :catalogs, :languages, :file_ids, :files, :patterns, :morning_lesson_files
            get :patterns
          end
          member do
          end
        end
      end
    end
  end

  # Redirect old landing pages
  get '/rss.php', to: 'feeds#rss_php', as: :rss_php, format: :rss
  get '/rss_video.php', to: 'feeds#rss_video', format: :rss

  get '/index.php', to: proc { |env|
    query = env['QUERY_STRING'].upcase
    case
    when query.match(/UILANG=RUS/)
      [301, { location: '/ru' }, []]
    when query.match(/UILANG=HEB/)
      [301, { location: '/he' }, []]
    when query.match(/SPA/)
      [301, { location: '/es' }, []]
    else
      [301, { location: '/en' }, []]
    end
  }

  get '/index_rus.html', to: proc { |env| [301, { location: '/ru' }, []] }
  get '/index_heb.html', to: proc { |env| [301, { location: '/he' }, []] }

  get '/smapless.php', to: proc { |env|
    query = env['QUERY_STRING'].upcase
    case
    when query.match(/CID=4500/)
      [301, { location: '/he/ui?search%5Bcatalog_ids%5D=4500' }, []]
    when query.match(/CID=1940/)
      [301, { location: '/he/ui?search%5Bcatalog_ids%5D=1940' }, []]
    when query.match(/CID=3691/)
      [301, { location: '/ru/ui?search%5Bcatalog_ids%5D=3691' }, []]
    when query.match(/CID=4613/)
      [301, { location: '/en/ui?search%5Bcatalog_ids%5D=4613' }, []]
    else
      [301, { location: '/en' }, []]
    end
  }

  get '/lesson-downloader.php', to: proc { |env|
    query = env['QUERY_STRING'].upcase
    lang  = case
            when query.match(/UILANG=RUS/)
              'ru'
            when query.match(/UILANG=HEB/)
              'he'
            else
              'en'
            end
    [301, { location: "/#{lang}/ui/lesson_downloader" }, []]
  }

  get '*path', to: redirect('/'), status: 301, constraints: ->(request) { request.path !~ /rails\/routes/ }
end
