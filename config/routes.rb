Rails.application.routes.draw do
  devise_for :staffs
  resources :tests
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'tests#index'
end
