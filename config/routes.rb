Rails.application.routes.draw do

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
        skip_controllers :applications, :authorized_applications, :authorizations
      end
      get 'posts', to: 'posts#index'
    end
  end
  
end
