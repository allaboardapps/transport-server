Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  # Auth0 routes for authentication
  get '/auth/auth0/callback' => 'auth0#callback'
  get '/auth/failure'        => 'auth0#failure'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  require "sidekiq/web"
  mount Sidekiq::Web, at: "/sidekiq"

  root "static#index"
  # Dashboard
  get 'dashboard' => 'dashboard#show'

  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      post :trains, to: "trains#index"
      get :skills, to: "skills#show"
    end
  end
end
