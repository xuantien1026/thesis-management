Rails.application.routes.draw do
  root to: "theses#index"
  devise_for :users
  get '/profile', to: 'profile#show'

  shallow do
    scope module: 'admin' do
      resources :faculties, only: %i[index show] do
        resources :theses, only: %i[index new create]
        resources :midterm_evaluations, only: :index

        resources :departments, only: [] do
          resources :defense_committees, only: %i[index new create] do
            collection do
              get 'suggest', to: 'defense_committees#suggest'
            end
          end
          resources :lecturers, only: :index do
            resource :role, only: %i[show create]
          end
        end
        resources :majors, only: :index
      end
    end

    namespace :department_management, as: :dept do
      resources :theses, only: :index do
        resource :thesis_review, except: :destroy, as: :review
      end
    end

    resources :thesis_proposals do
      member do
        post 'department_approve', to: 'thesis_proposals#department_approve'
        post 'faculty_approve', to: 'thesis_proposals#faculty_approve'
      end
      resources :thesis_proposal_members, only: %i[create], as: :applications
    end

    resources :theses, only: %i[index show] do
      collection do
        resource :midterm_evaluations, only: %i[show new create]
      end
      resource :midterm_evaluations, only: %i[edit update]
      resources :thesis_members, only: %i[create], as: :applications
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
