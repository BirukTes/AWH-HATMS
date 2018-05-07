Rails.application.routes.draw do

  resources :invoices
  resources :wards
  resources :drugs
  resources :patients
  resources :teams
  resources :admissions do
    member do
      get :discharge
    end
    member do
      post :authorise_discharge
    end
    collection do
      get :find_and_discharge
    end
  end
  resources :treatments
  resources :prescriptions
  resources :specialities
  resources :job_titles

  # Find controller under search module and it is actions
  namespace :search do
    get 'find_patients_in_ward', to: 'find#find_patients_in_ward'
    get 'find_patients_discharge_unauthorised', to: 'find#find_patients_discharge_unauthorised'
  end


  # Change devise routes from staffs/login to /login
  devise_for :staffs, path: '',
             path_names: { sign_in: 'login', sign_up: 'register', account_update: 'update' },
             controllers: { sessions: 'sessions' }

  devise_scope :staff do
    authenticated :staff do
      root to: 'home#index'
    end

    unauthenticated :staff do
      root to: 'sessions#new'
    end


  end

  resources :staffs

  get :home, to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'sessions#login'

match '/404', to: 'error#not_found', via: :all
match '/500', to: 'error#internal_server_error', via: :all
end
