require 'rails_helper'
RSpec.describe Api::V1::RegistrationsController, type: :request do

  describe "POST   /api/v1/users(.:format)" do

    context "datos validos" do

      before :each do
        @user = FactoryBot.build(:user)
        post user_registration_path, params: { user: {email:@user.email,password:@user.password,password_confirmation:@user.password_confirmation} }
      end

      it{	expect(response).to have_http_status(:created) }

      it{ change(User,:count).by(1) }

      it "responds with user found or create" do
        json = JSON.parse(response.body)
        expect(json["email"]).to eq(@user.email)
      end

    end

    context "Email invalido" do

      before :each do
        @user = FactoryBot.build(:user)
        post user_registration_path, params: { user: {email:"root",password:@user.password,password_confirmation:@user.password_confirmation} }
      end

      it{	expect(response).to have_http_status(:unprocessable_entity) }

      it{ change(User,:count).by(0)}

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]["email"]).to_not be_empty
      end

    end

    context "Email password invaludo" do

      before :each do
        @user = FactoryBot.build(:user_failer)
        post user_registration_path, params: { user: {email:@user.email,password:@user.password,password_confirmation:@user.password_confirmation} }
      end

      it{	expect(response).to have_http_status(:unprocessable_entity) }

      it{ change(User,:count).by(0)}

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]["password"]).to_not be_empty
      end

    end

  end


end
