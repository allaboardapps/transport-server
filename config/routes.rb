Rails.application.routes.draw do
  ActiveAdmin.routes(self) rescue ActiveAdmin::DatabaseHitDuringLoad

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  require "sidekiq/web"
  mount Sidekiq::Web, at: "/sidekiq"

  root "static#index"

  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      post :trains, to: "trains#index"
    end
  end
end
