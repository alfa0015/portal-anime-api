# == Route Map
#

Rails.application.routes.draw do
  #route for redirect swagger
  get '/' => redirect('/swagger/dist/index.html')

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
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      #route for configuration consumer swagger
      get '/apidocs', to: 'swagger#index'
      resources :posts
      resources :animes do
        post '/add_tags', to: "animes#add_tags"
        delete '/delete_tags', to: "animes#delete_tags"
        get '/episodes', to: "animes#episodes", as: "episodes"
        resources :episodes, only:[:create]
      end
      resources :episodes, except:[:create]
      resources :rcontrollers do
        resources :ractions
      end
    end
  end

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end
