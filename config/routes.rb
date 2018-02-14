Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :applications, :authorized_applications, :authorizations
  end
  devise_for :users
  namespace :api do
    namespace :v1 do
      # use_doorkeeper do
      #   skip_controllers :applications, :authorized_applications, :authorizations
      # end
      get 'posts', to: 'posts#index'
    end
  end
end
