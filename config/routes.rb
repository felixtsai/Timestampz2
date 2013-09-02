Timestampz2::Application.routes.draw do

  devise_for :users
  root to: 'groups#index'

  resources :assignments
  match '/assignments/add_form', to: 'assignments#add_form', via: :get

  resources :groups do
    resources :students, only: [:index, :show]
  end

  resources :schools, shallow: true do
    resources :teachers, except: [:show, :index]
    resources :day_classes, except: [:show, :index]
  end

  resources :students
  resources :student_assignments

  resources :reports, only: [:index]
  match 'reports/:category',  to: 'reports#show', via: :get
  
end
