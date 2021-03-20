Rails.application.routes.draw do
  root to: "topics#index"
  devise_for :users

  resources :topics do
    member do
      post 'department_approve', to: 'topics#department_approve'
      post 'faculty_approve', to: 'topics#faculty_approve'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
