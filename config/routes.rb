Rails.application.routes.draw do
  get '/' => 'home#index'
  root :to => 'home#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  devise_scope :user do
    get 'users/sign_out' => 'devise/sessions#destroy'
    get 'users/account' => 'devise/registrations#show'
    get 'users/account/edit' => 'devise/registrations#edit'
    get 'users/profile' => 'profile#show'
    get 'users/profile/edit' => 'profile#edit'
    patch 'users/profile/edit' => 'profile#update'
  end
  
  devise_for :users, controllers: {
       registrations: 'users/registrations',
       sessions: 'users/sessions'
  }
  
  resources :users
  
  resources :rooms do
    collection do
      get 'search'
      get 'own'
    end
  end
  
      
  resources :reservations do
    collection do
      post 'confirm'
    end
  end

  
  resource :profile, only: [:show, :edit, :update]

end
