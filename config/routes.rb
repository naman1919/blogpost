Rails.application.routes.draw do
  
  root to: 'posts#index'
  
  scope module: 'api' do
    namespace :v1 do
      devise_for :users, controllers: { sessions: 'api/v1/users/sessions', registrations: 'api/v1/users/registrations'}
    end
  end
  # devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations'}
  resources :posts do
    resources :images
    resources :comments
    get 'approve',on: :member 
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
