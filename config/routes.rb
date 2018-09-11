Rails.application.routes.draw do
  root :to => "web/board#show"

  namespace :admin do
    resources :users
  end

  namespace :api do
    namespace :v1 do
      resources :tasks, defaults: {format: 'json'}, only: [:index, :show, :create, :update, :destroy]
    end
  end

  scope module: :web do
    resource :board, only: :show
    resource :session, only: [:new, :create, :destroy]
    resources :developers, only: [:new, :create]
  end
end
