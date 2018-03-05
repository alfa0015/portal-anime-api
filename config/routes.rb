# == Route Map
#

Rails.application.routes.draw do
  #Configuration for Module Devise And Doorkeeper
  scope :api , defaults: { format: :json } do
    scope :v1 do
      devise_for :users,
      skip: [:sessions],
      defaults: {
        format: :json
      },
      controllers:{
        registrations: "api/v1/registrations"
      }
      use_doorkeeper do
        controllers :tokens => 'api/v1/access_token'
        skip_controllers :applications, :authorized_applications, :authorizations
      end

    end
  end
  #Routes for application
  namespace :api do
    namespace :v1 do
      resources :posts
    end
  end

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end
