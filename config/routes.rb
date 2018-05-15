Rails.application.routes.draw do

  namespace :reports do
    get :ward_list
    get :medications_list
    get :discharge_list
    get :patient_card
  end
  resource :invoice_payments
  resources :diagnoses
  resources :invoices do
    member do
      get :receive_payment
    end
    collection do
      post :set_payment_received
    end
  end
  resources :wards do
    collection do
      match 'search' => 'wards#search', via: [:get, :post], as: :search
    end
  end
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
      post :authorise_discharge
    end
    # Collections do not require id
    collection do
      get :find_and_discharge
      match 'search' => 'admissions#search', via: [:get, :post], as: :search
    end
  end

  # Find controller under search module and it is actions
  namespace :search do
    get :search, to: 'search#search', as: :search
    get 'find_admitted_patients_in_ward', to: 'find#find_admitted_patients_in_ward'
    get 'find_patients_discharge_unauthorised', to: 'find#find_patients_discharge_unauthorised'
    get 'find_discharged_without_invoice_patients_in_ward', to: 'find#find_discharged_without_invoice_patients_in_ward'
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
