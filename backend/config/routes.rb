# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json }, constraints: { format: :json } do
    namespace :v1 do
      resources :dealers, only: :index
    end
  end
end
