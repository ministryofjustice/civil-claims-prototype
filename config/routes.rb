CivilClaims::Application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'claims#home'

  # relax, it's a prototype.
  
  get "claims/delete_all" => "claims#delete_all"
  
  

  get 'login_as/:role' => 'people#login', as: :login

  get 'address/:id'    => 'address#get', as: :get_address
  get 'address/picker' => 'address#picker', as: :address_picker

  get 'claims/:claim_id/address/:id/edit' => 'address#editor', as: :claim_address_editor
  
  resources :claims do
    member do
      get '/' => 'claims#personal_details', as: :show_claim
      get 'particulars'
      get 'scheduling'
      get 'statement'
      get 'fees'
      get 'confirmation'

      patch "update", as: :update_claim
      patch 'address_for_possession' => 'claims#address', as: :address_for_possession

      get 'delete'
    end
    resources :people do
      get 'editor', on: :member
      resources :address do
        get 'editor', on: :member
        get 'copy_address_of_first', on: :member
      end
    end
  end


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
