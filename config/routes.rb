Rails.application.routes.draw do
  get 'job_titles/new'

  get 'job_titles/create'

  get 'job_titles/edit'

  get 'job_titles/update'

  get 'job_titles/destroy'

  get 'specialities/new'

  get 'specialities/create'

  get 'specialities/edit'

  get 'specialities/update'

  get 'specialities/destroy'

  # Change devise routes from staffs/login to /login
  devise_for :staffs, path: '',
             path_names: {sign_in: 'login', sign_up: 'register', account_update: 'update'},
             controllers: {sessions: 'sessions'}

  devise_scope :staff do
    authenticated :staff do
      root to: 'tests#index'
    end

    unauthenticated :staff do
      root to: 'sessions#new'
    end
  end
  resources :tests
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'tests#index'


end
