Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  require "sidekiq/web"
  mount Sidekiq::Web, at: "/sidekiq"


  if Rails.env.development? || Rails.env.test?
    mount RailsDb::Engine, at: "/rails/db", as: "rails_db"
  end

  root "static#index"
end
