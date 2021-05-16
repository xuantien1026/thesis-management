Rails.application.routes.draw do
  root to: "theses#index"
  devise_for :users

  get '/profile', to: 'profile#show'

  scope module: 'admin' do
    resources :faculties, only: %i[index show], shallow: true do
      resources :theses, only: %i[index new create]
      resources :midterm_evaluations, only: :index

      resources :departments, only: [] do
        resources :lecturers, only: :index do
          resource :role, only: %i[show create]
        end
      end
      resources :majors, only: :index
    end
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
    resource :midterm_evaluations, only: %i[edit update]
    resources :thesis_members, only: %i[create], as: :applications
  end

  resources :defense_committees, only: %i[index new create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
