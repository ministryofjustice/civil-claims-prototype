CivilClaims::Application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'claims#home'

  # relax, it's a prototype.
  get 'claims/:id/delete' => 'claims#delete', as: :claim_delete
  get "claims/delete_all" => "claims#delete_all"
  # post "claims/:id/update" => "claims#update", as: :update_claim
  patch "claims/:id/update" => "claims#update", as: :update_claim
  # match "claims/:id/update" => "claims#update", as: :update_claim, via: post
 
  get 'claims/:id' => 'claims#personal_details', as: :show_claim
  get 'claims/:id/particulars' => 'claims#particulars'
  get 'claims/:id/scheduling' => 'claims#scheduling'
  get 'claims/:id/statement' => 'claims#statement'
  get 'claims/:id/fees' => 'claims#fees'
  get 'claims/:id/confirmation' => 'claims#confirmation'

  get 'login_as/:role' => 'people#login', as: :login

  get 'address/random' => 'address#random', as: :random_address
  get 'address/:id'    => 'adddress#get', as: :get_address
  
  resources :claims do
    resources :people do
      get 'editor', on: :member
      resources :address do
        get 'editor', on: :member
        get 'picker', on: :member
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
