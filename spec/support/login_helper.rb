module LoginHelpers
  def log_in
    user = FactoryBot.create(:user)
    post oauth_token_path, params: { email:user.email,password:user.password,grant_type:"password" }
    json = JSON.parse(response.body)
    access_token = json["access_token"]
  end

  def log_in_admin
    user = FactoryBot.create(:user)
    user.add_role(:webmaster)
    post oauth_token_path, params: { email:user.email,password:user.password,grant_type:"password" }
    json = JSON.parse(response.body)
    access_token = json["access_token"]
  end
end
