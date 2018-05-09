Rails.application.routes.draw do

  get 'reports/ward_list'
  get 'reports/medications_list'
  get 'reports/discharge_list'
  get 'reports/patient_card'

  resources :invoices
  resources :wards
  resources :drugs
  resources :patients
  resources :teams
  resources :treatments
  resources :prescriptions
  resources :staffs
  resources :specialities
  resources :job_titles
  resources :admissions do
    # Members require admission id
    member do
      get :discharge
    end
    member do
      post :authorise_discharge
    end
    # Collection do not require id
    collection do
      get :find_and_discharge
    end
  end

  # Find controller under search module and it is actions
  namespace :search do
    get 'find_patients_in_ward', to: 'find#find_patients_in_ward'
    get 'find_patients_discharge_unauthorised', to: 'find#find_patients_discharge_unauthorised'
  end


  # Change devise routes from staffs/login to /login
  devise_for :staffs, path: '',
             path_names: { sign_in: 'login', sign_up: 'register', account_update: 'update' },
             controllers: { sessions: 'sessions' }

  # On the scope of devise, manage authenticated and unauthenticated users
  devise_scope :staff do
    authenticated :staff do
      root to: 'home#index'
    end
    unauthenticated :staff do
      root to: 'sessions#new'
    end
  end

  get :home, to: 'home#index'

  root to: 'sessions#login'

  # Handle errors, must be at end
  match '/404', to: 'error#not_found', via: :all
  match '/500', to: 'error#internal_server_error', via: :all
end
