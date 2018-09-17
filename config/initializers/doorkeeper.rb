Doorkeeper.configure do

  orm :active_record

  resource_owner_from_credentials do
    user = User.find_for_database_authentication(email: params[:email])
    if user && user.valid_for_authentication? {user.valid_password?(params[:password])}
      user
    end
  end

  # If you want to disable expiration, set this to nil.
  access_token_expires_in 120.hours
  # Issue access tokens with refresh token (disabled by default)
  use_refresh_token

end
Doorkeeper.configuration.token_grant_types << 'password'
