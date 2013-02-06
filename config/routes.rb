Spree::Core::Engine.routes.draw do
  devise_for :user,
             :class_name => 'Refinery::User',
             :controllers => { :sessions => 'spree/user_sessions',
                               :registrations => 'spree/user_registrations',
                               :passwords => 'spree/user_passwords' },
             :skip => [:unlocks, :omniauth_callbacks],
             :path_names => { :sign_out => 'logout' }
end

Spree::Core::Engine.routes.prepend  do
  resources :users, :only => [:edit, :update]

  devise_scope :user do
    get '/login' => 'user_sessions#new', :as => :login
    get '/signup' => 'user_registrations#new', :as => :signup
  end

  match '/checkout/registration' => 'checkout#registration', :via => :get, :as => :checkout_registration
  match '/checkout/registration' => 'checkout#update_registration', :via => :put, :as => :update_checkout_registration

  resource :account, :controller => 'users'
end
