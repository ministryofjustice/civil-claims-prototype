CivilClaims::Application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'claims#home'

  # relax, it's a prototype.
  
  get "claims/delete_all" => "claims#delete_all"
  get 'login_as/:role' => 'people#login', as: :login

  get 'claims/:claim_id/address/:id/edit' => 'address#editor', as: :claim_address_editor
  
  get 'address/picker' => 'address#picker', as: :address_picker

  get 'claims/defence' => 'defence#show_login'
  post 'claims/defence' => 'defence#login'

  resources :claims do
    member do
      get '/' => 'claims#personal_details', as: :show_claim
      get 'particulars'
      get 'scheduling'
      get 'statement'
      get 'fees'
      get 'confirmation'

      patch "update", as: :update_claim
      patch 'address_for_possession', to: 'claims#address', as: :address_for_possession

      get 'delete'

    end

    resources :people do
      get 'editor', on: :member
      resources :address do
        get 'editor', on: :member
        get 'copy_address_of_first', on: :member
      end
    end

    resource :defence do
      get '/' => 'defence#index'


    end

  end

end
