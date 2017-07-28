Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web, at: "/sidekiq"
  end

  if Rails.env.development? || Rails.env.test?
    authenticate :user, lambda { |u| u.admin? } do
      mount RailsDb::Engine, at: "/rails/db", as: "rails_db"
    end
  end

  root "static#index"
end
