Rails.application.routes.draw do
  root 'homes#landing'
  devise_for :users

  resources :sections, only: [:index] do
    resources :students, only: [:index]
    resources :assignments, only: [:index, :show]
  end

  resources :students, only: [:show]
end
