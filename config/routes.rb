Rails.application.routes.draw do
  root to: "home#homepage"
  devise_for :users
  get '/profile', to: 'profile#show'

  shallow do
    namespace :admin do
      resources :faculties, only: %i[index show] do
        resources :theses, only: :index
        resources :midterm_evaluations, only: :index

        resources :departments, only: [] do
          resources :lecturers, only: %i[index show] do
            resource :role, only: :create
          end
        end
      end
      resource :lecturer_import, only: %i[new create]
    end

    namespace :department_management, as: :dept do
      resources :thesis_proposals, only: :index
      resources :lecturers, only: %i[index show]
      resources :theses, only: :index do
        scope module: :theses do
          resource :review, except: :destroy
        end
      end
      resources :defense_committees, only: %i[index new create] do
        collection do
          get 'suggest', to: 'defense_committees#suggest'
        end
      end
    end

    namespace :faculties do
      resources :thesis_proposals, only: :index
    end

    namespace :students do
      resources :thesis_proposals, only: :index
    end

    namespace :theses do
      resources :reviews, only: :index
      resource :midterm_evaluation_set, except: :destroy
      resources :members, only: [] do
        resource :advisor_evaluation, except: :destroy
        resource :reviewer_evaluation, except: :destroy
      end
    end

    resources :theses, only: %i[index show] do
      scope module: :theses do
        resource :batch_advisor_evaluation, only: %i[new create]
        resource :batch_reviewer_evaluation, only: %i[new create]
        resource :mission_note, only: :show
      end
    end

    resources :thesis_proposals do
      member do
        post 'department_approve', to: 'thesis_proposals#department_approve'
        post 'faculty_approve', to: 'thesis_proposals#faculty_approve'
      end
      resources :thesis_proposal_members, only: %i[create], as: :applications
    end

    resources :defense_committees, only: %i[index show] do
      member do
        post 'start_session', to: 'defense_committees#start_session'
        post 'end_session', to: 'defense_committees#end_session'
      end
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
