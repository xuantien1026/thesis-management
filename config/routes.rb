Rails.application.routes.draw do
  root to: "theses#index"
  devise_for :users

  get '/profile', to: 'profile#show'

  resources :faculties, only: %i[index show], shallow: true do
    resources :departments, only: :index do
      resources :lecturers, only: :index
    end
    resources :majors, only: :index
  end

  resources :thesis_proposals do
    member do
      post 'department_approve', to: 'thesis_proposals#department_approve'
      post 'faculty_approve', to: 'thesis_proposals#faculty_approve'
    end
    resources :thesis_proposal_members, only: %i[create], as: :applications
  end

  resources :theses, only: %i[index show], shallow: true do
    collection do
      resource :midterm_evaluations, only: %i[show new create]
    end
    resources :thesis_members, only: %i[create], as: :applications
  end

  resources :defense_committees, only: %i[index new create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
