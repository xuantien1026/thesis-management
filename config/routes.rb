Rails.application.routes.draw do
  root to: "theses#index"
  devise_for :users

  resources :thesis_proposals do
    member do
      post 'department_approve', to: 'thesis_proposals#department_approve'
      post 'faculty_approve', to: 'thesis_proposals#faculty_approve'
    end
  end

  resources :theses, only: %i[index show] do
    member do
      get '/midterm_evaluations', to: 'midterm_evaluations#new'
      post '/midterm_evaluations', to: 'midterm_evaluations#evaluate_all_students'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
