Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  require "sidekiq/web"
  mount Sidekiq::Web, at: "/sidekiq"

  root "static#index"
end
