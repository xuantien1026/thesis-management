Rails.application.routes.draw do
  root to: "home#homepage"
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  get '/profile', to: 'profile#show'

  shallow do
    namespace :admin do
      resources :faculties, only: %i[index show] do
        resources :theses, only: %i[index new create] do
          resources :thesis_members, only: %i[new create destroy]
        end
        resources :midterm_evaluations, only: :index

        resources :departments, only: [] do
          resources :lecturers, only: %i[index show] do
            resource :role, only: :create
          end
        end
      end
      resources :major_committees, only: %i[show]
      resource :lecturer_import, only: %i[new create]
      resource :student_import, only: %i[new create]
    end

    namespace :department_management, as: :dept do
      resources :thesis_proposals, only: :index do
        resource :review, except: :destroy, module: 'thesis_proposals'
        collection do
          resource :review_assignment, only: :show, module: 'thesis_proposals'
        end
      end
      resources :lecturers, only: %i[index show]
      resources :theses, only: :index do
        resource :review, except: :destroy, module: :theses
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
      resources :thesis_proposals, only: %i[index show] do
        collection do
          get 'registered', to: 'thesis_proposals#registered', as: :registered
        end
        resources :members, only: %i[create destroy], module: :thesis_proposal, shallow: false
      end
      resource :my_thesis, only: :show
    end

    namespace :theses do
      resources :reviews, only: :index
      resource :midterm_evaluation_set, except: :destroy
      resources :members, only: [] do
        resource :advisor_evaluation, except: :destroy
        resource :reviewer_evaluation, except: :destroy
        resources :committee_evaluations, only: %i[show new create]
      end
    end

    resources :theses, only: %i[index show] do
      scope module: :theses do
        resource :batch_advisor_evaluation, only: %i[new create]
        resource :batch_reviewer_evaluation, only: %i[new create]
        resource :mission_note, only: :show
        resource :final_submission, only: %i[show create]
      end
    end

    namespace :thesis_proposals do
      resources :reviews, only: :index
      resource :final_evaluations, only: %i[new create]
    end

    resources :thesis_proposals do
      member do
        post 'department_approve', to: 'thesis_proposals#department_approve'
        post 'major_committee_approve', to: 'thesis_proposals#major_committee_approve'
        post 'faculty_approve', to: 'thesis_proposals#faculty_approve'
      end
      resource :reviewer_evaluation, module: 'thesis_proposals'
    end

    resources :defense_committees, only: %i[index show] do
      member do
        post 'start_session', to: 'defense_committees#start_session'
        post 'end_session', to: 'defense_committees#end_session'
      end
      resource :report, only: :show
    end

    resources :major_committees, only: [] do
      resources :thesis_proposals, only: :index, module: :major_committees
    end

    resources :semesters, only: :index
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
