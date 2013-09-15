Timestampz2::Application.routes.draw do

  devise_for :users
  root to: 'groups#index'

  resources :assignments
  resources :groups

  resources :schools, shallow: true do
    resources :teachers, except: [:show, :index]
    resources :day_classes, except: [:show, :index]
  end

  resources :students do
    member do
      get 'assignments'
    end
  end

  resources :student_assignments

  resources :reports, only: [:index]
  match 'reports/:category',  to: 'reports#show', via: :get
  
end
