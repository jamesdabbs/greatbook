Rails.application.routes.draw do
  devise_for :users

  resources :courses, only: %i(index create) do
    resources :terms, only: [] do
      resources :sections, only: %i(index create update), shallow: true
    end
  end

  resources :sections, only: [] do
    resources :students, only: [] do
      resource :grade, only: %i(create update)
    end
  end

  root to: 'home#index'
end
