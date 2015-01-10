Int::Application.routes.draw do
  
  post "formularios/:formulario_id/personas_fisicas_e/:id" => "personas_fisicas_e#create", as: :formulario_personas_fisicas_e
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :password_recovers, only: [:new, :create]
  resources :ver_formularios, only: [:index]
  resources :formularios, only: [:index] do
    member do
      get :imprimir_remito
      get :imprimir_formulario_interno
    end
    resources :principals, only: [:new, :create, :show, :edit, :update] do
      member do
        get :errores
      end
    end
    resources :elencos_en_gira, only: [:index, :show] do
      member do
        get :errores
      end
    end
    resources :integrantes_de_elenco_en_gira, only: [:new, :create, :show, :edit, :update, :destroy]
    resources :actores, controller: 'integrantes_de_elenco_en_gira', type: 'Actor'
    resources :directores, controller: 'integrantes_de_elenco_en_gira', type: 'Director'
    resources :tecnicos, controller: 'integrantes_de_elenco_en_gira', type: 'Tecnico'
    resources :datos_grupos, only: [:new, :create, :show, :edit, :update, :destroy] do
      member do
        get :errores
      end
    end
    resources :datos_esps, only: [:new, :create, :show, :edit, :update, :destroy] do
      member do
        get :errores
      end
    end
    resources :datos_tecs, only: [:new, :create, :show, :edit, :update, :destroy] do
      member do
        get :errores
      end
    end
    resources :responsables, only: [:new, :create, :show, :edit, :update, :destroy, :index] do
      member do
        get :errores
      end
    end
    resources :personas_juridicas, only: [:new, :create, :show, :edit, :update, :index]
    resources :integrantes_comision_directiva, only: [:new, :create, :show, :edit, :update, :index, :destroy]
    resources :personas_fisicas_n, only: [:new, :create, :show, :edit, :update]
    resources :personas_fisicas_e, only: [:new, :create, :show]
    resources :ficha_artisticas, only: [:new, :create, :show, :edit, :update, :index, :destroy]
    resources :super_vistas, only: [:index]
    resources :formularios_terminados, only: [:index]
    resources :excel_formularios, only: [:index]
    resources :personas_fisicas_e, only: [:new, :show, :index] do
      member do
        post :buscar_integrante_por_cuil_cuit
        get :vista
      end
    end
  end
  get "principals/obtener_region", :defaults => {:format => :js}
  


  root 'sessions#new'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
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
