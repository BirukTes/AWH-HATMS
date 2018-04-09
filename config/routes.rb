Rails.application.routes.draw do
  # Change devise routes from staffs/login to /login
  devise_for :staffs, path: '', path_names: { sign_in: 'login',
                                              sign_out: 'logout',
                                              sign_up: 'register',
                                              account_update: 'update'}
  resources :tests
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'tests#index'
end
