Rails.application.routes.draw do
  root to: "theses#index"
  devise_for :users
  # get '/faculties/:faculty_id/departments/:id/', to: 'lecturer#department'
  # get '/faculties/:faculty_id', to: 'lecturer#index'
  post '/majors/:id/edit', to: 'majors#update'
  delete '/majors/:id', to: 'majors#destroy'
  resources :faculties, only: %i[index show], shallow: true do
    resources :departments, only: :index do
      resources :lecturers, only: :index
    end
    resources :majors
  end

  resources :thesis_proposals do
    member do
      post 'department_approve', to: 'thesis_proposals#department_approve'
      post 'faculty_approve', to: 'thesis_proposals#faculty_approve'
    end
    resources :thesis_proposal_members, only: %i[create], as: :applications
  end

  resources :theses, only: %i[index show] do
    member do
      get '/midterm_evaluations', to: 'midterm_evaluations#new'
      post '/midterm_evaluations', to: 'midterm_evaluations#evaluate_all_students'
    end
    resources :thesis_members, only: %i[create], as: :applications
  end

  resources :defense_committees, only: %i[index new create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
