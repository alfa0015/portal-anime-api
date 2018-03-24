require 'rails_helper'

RSpec.describe "Animes", type: :request do

  let(:admin_header){
    {
      "Authorization":"bearer #{log_in_admin}"
    }
  }

  let(:user_header){
    {
      "Authorization":"bearer #{log_in}"
    }
  }

  let(:invalid_header){
    {
      "Authorization":"bearer"
    }
  }


  let(:valid_attributes){
    @anime = FactoryBot.build(:anime)
  }

  let(:tag){
    {
      tags:{
        name:"tag_name"
      }
    }

  }

  let(:update_attributes){
    {
      name:"new_name 123490450"
    }
  }

  describe "GET /api/v1/animes" do

    context "with valid token & admin" do

      before :each do
        FactoryBot.create_list(:anime,30)
        get api_v1_animes_path, headers:admin_header, as: :json
      end

      it{	expect(response).to have_http_status(:ok) }

      it "response with current page" do
        headers = response.headers
        expect(headers["x-page"]).to eq(1)
      end

      it "response with correctly number records" do
        headers = response.headers
        expect(headers["x-total"]).to eq(Anime.count)
      end

      it "response with number records per page" do
        headers = response.headers
        expect(headers["x-per-page"]).to eq(25)
      end

      it "response with next page" do
        headers = response.headers
        expect(headers["next_page"]).to_not be_empty
      end

      it "response with prev page" do
        get response.headers["next_page"], headers:{"Authorization":"bearer #{log_in}"}
        headers = response.headers
        expect(headers["prev_page"]).to_not be_empty
      end

      it "response with correctly number record on page" do
        json = JSON.parse(response.body)
        headers = response.headers
        expect(json.length).to eq(Anime.page(headers["x-page"]).count)
      end

    end

    context "with valid token" do

      before :each do
        FactoryBot.create_list(:anime,30)
        get api_v1_animes_path, headers:user_header, as: :json
      end

      it{	expect(response).to have_http_status(:ok) }

      it "response with current page" do
        headers = response.headers
        expect(headers["x-page"]).to eq(1)
      end

      it "response with correctly number records" do
        headers = response.headers
        expect(headers["x-total"]).to eq(Anime.count)
      end

      it "response with number records per page" do
        headers = response.headers
        expect(headers["x-per-page"]).to eq(25)
      end

      it "response with next page" do
        headers = response.headers
        expect(headers["next_page"]).to_not be_empty
      end

      it "response with prev page" do
        get response.headers["next_page"], headers:{"Authorization":"bearer #{log_in}"}
        headers = response.headers
        expect(headers["prev_page"]).to_not be_empty
      end

      it "response with correctly number record on page" do
        json = JSON.parse(response.body)
        headers = response.headers
        expect(json.length).to eq(Anime.page(headers["x-page"]).count)
      end

    end

    context "with invalid token" do

      before :each do
        FactoryBot.create_list(:anime,30)
        get api_v1_animes_path, headers:invalid_header, as: :json
      end

      it{	expect(response).to have_http_status(:ok) }

      it "response with current page" do
        headers = response.headers
        expect(headers["x-page"]).to eq(1)
      end

      it "response with correctly number records" do
        headers = response.headers
        expect(headers["x-total"]).to eq(Anime.count)
      end

      it "response with number records per page" do
        headers = response.headers
        expect(headers["x-per-page"]).to eq(25)
      end

      it "response with next page" do
        headers = response.headers
        expect(headers["next_page"]).to_not be_empty
      end

      it "response with prev page" do
        get response.headers["next_page"], headers:{"Authorization":"bearer #{log_in}"}
        headers = response.headers
        expect(headers["prev_page"]).to_not be_empty
      end

      it "response with correctly number record on page" do
        json = JSON.parse(response.body)
        headers = response.headers
        expect(json.length).to eq(Anime.page(headers["x-page"]).count)
      end

    end

  end

  describe "POST /api/v1/animes" do

    context "with valid token & admin" do

      before :each do
        post api_v1_animes_path, headers:admin_header, params:{ anime: valid_attributes }, as: :json
      end

      it { expect(response).to have_http_status(:created) }

      it "create to rcontroller" do
        anime = FactoryBot.build(:anime,name:"new_name 123450")
        expect{
          post api_v1_animes_path, headers:admin_header, params:{ anime: anime }, as: :json
        }.to change(Anime,:count).by(1)
      end

    end

    context "with valid token" do

      before :each do
        post api_v1_animes_path, headers:user_header, params:{ anime: valid_attributes }, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "create to rcontroller" do
        anime = FactoryBot.build(:anime,name:"new_name 123450")
        expect{
          post api_v1_animes_path, headers:user_header, params:{ anime: anime }, as: :json
        }.to change(Anime,:count).by(0)
      end

    end

    context "with invalid token" do

      before :each do
        post api_v1_animes_path, headers:user_header, params:{ anime: valid_attributes }, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "create to rcontroller" do
        anime = FactoryBot.build(:anime,name:"new_name 123450")
        expect{
          post api_v1_animes_path, headers:user_header, params:{ anime: anime }, as: :json
        }.to change(Anime,:count).by(0)
      end

    end

  end

  describe "GET /api/v1/animes/:id" do

    context "with valid token & admin" do

      before :each do
        @anime = FactoryBot.create(:anime)
        get api_v1_anime_path(@anime), headers:admin_header, as: :json
      end

      it { expect(response).to have_http_status(:ok) }

      it "response with category" do
        json = JSON.parse(response.body)
        expect(json["id"]).to eq(@anime.id)
      end

      it "Manda los atributos del menu" do
        json = JSON.parse(response.body)
        expect(json.keys).to contain_exactly("id","name","synopsis","sessions","episodes","created_at","updated_at","url")
      end

    end

    context "with valid token & admin & invalid id" do

      before :each do
        @anime = FactoryBot.create(:anime)
        get api_v1_anime_path(1111), headers:admin_header, as: :json
      end

      it { expect(response).to have_http_status(:not_found) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with valid token" do

      before :each do
        @anime = FactoryBot.create(:anime)
        get api_v1_anime_path(@anime), headers:user_header, as: :json
      end

      it { expect(response).to have_http_status(:ok) }

      it "response with category" do
        json = JSON.parse(response.body)
        expect(json["id"]).to eq(@anime.id)
      end

      it "Manda los atributos del menu" do
        json = JSON.parse(response.body)
        expect(json.keys).to contain_exactly("id","name","synopsis","sessions","episodes","created_at","updated_at","url")
      end

    end

    context "with valid token & invalid id" do

      before :each do
        @anime = FactoryBot.create(:anime)
        get api_v1_anime_path(1111), headers:user_header, as: :json
      end

      it { expect(response).to have_http_status(:not_found) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with invalid token" do

      before :each do
        @anime = FactoryBot.create(:anime)
        get api_v1_anime_path(@anime), headers:invalid_header, as: :json
      end

      it { expect(response).to have_http_status(:ok) }

      it "response with category" do
        json = JSON.parse(response.body)
        expect(json["id"]).to eq(@anime.id)
      end

      it "Manda los atributos del menu" do
        json = JSON.parse(response.body)
        expect(json.keys).to contain_exactly("id","name","synopsis","sessions","episodes","created_at","updated_at","url")
      end

    end

    context "with invalid token & invalid id" do

      before :each do
        @anime = FactoryBot.create(:anime)
        get api_v1_anime_path(1111), headers:invalid_header, as: :json
      end

      it { expect(response).to have_http_status(:not_found) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

  end

  describe "PATCH  /api/v1/animes/:id" do

    context "with valid token & admin" do

      before :each do
        @anime = FactoryBot.create(:anime)
        patch api_v1_anime_path(@anime), headers:admin_header, params:update_attributes, as: :json
      end

      it { expect(response).to have_http_status(:ok) }

      it "update anime" do
				json = JSON.parse(response.body)
				expect(json["name"]).to eq("new_name 123490450")
			end

    end

    context "with valid token & admin & invalid id" do

      before :each do
        @anime = FactoryBot.create(:anime)
        patch api_v1_anime_path(1111), headers:admin_header, params:update_attributes, as: :json
      end

      it { expect(response).to have_http_status(:not_found) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with valid token" do

      before :each do
        @anime = FactoryBot.create(:anime)
        patch api_v1_anime_path(@anime), headers:user_header, params:update_attributes, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with valid token & invalid id" do

      before :each do
        @anime = FactoryBot.create(:anime)
        patch api_v1_anime_path(1111), headers:user_header, params:update_attributes, as: :json
      end

      it { expect(response).to have_http_status(:not_found) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with invalid token" do

      before :each do
        @anime = FactoryBot.create(:anime)
        patch api_v1_anime_path(@anime), headers:invalid_header, params:update_attributes, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with invalid token & invalid id" do

      before :each do
        @anime = FactoryBot.create(:anime)
        patch api_v1_anime_path(1111), headers:invalid_header, params:update_attributes, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

  end

  describe "PUT  /api/v1/animes/:id" do

    context "with valid token & admin" do

      before :each do
        @anime = FactoryBot.create(:anime)
        put api_v1_anime_path(@anime), headers:admin_header, params:update_attributes, as: :json
      end

      it { expect(response).to have_http_status(:ok) }

      it "update anime" do
				json = JSON.parse(response.body)
				expect(json["name"]).to eq("new_name 123490450")
			end

    end

    context "with valid token & admin & invalid id" do

      before :each do
        @anime = FactoryBot.create(:anime)
        put api_v1_anime_path(1111), headers:admin_header, params:update_attributes, as: :json
      end

      it { expect(response).to have_http_status(:not_found) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with valid token & invalid id" do

      before :each do
        @anime = FactoryBot.create(:anime)
        put api_v1_anime_path(1111), headers:user_header, params:update_attributes, as: :json
      end

      it { expect(response).to have_http_status(:not_found) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with valid token" do

      before :each do
        @anime = FactoryBot.create(:anime)
        put api_v1_anime_path(@anime), headers:user_header, params:update_attributes, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with invalid token" do

      before :each do
        @anime = FactoryBot.create(:anime)
        put api_v1_anime_path(@anime), headers:invalid_header, params:update_attributes, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with invalid token & invalid id" do

      before :each do
        @anime = FactoryBot.create(:anime)
        put api_v1_anime_path(1111), headers:invalid_header, params:update_attributes, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

  end

  describe "DELETE /api/v1/animes/:id" do

    context "with valid token & admin" do

      before :each do
        @anime = FactoryBot.create(:anime)
      end

      it {
        delete api_v1_anime_path(@anime), headers:admin_header, as: :json
        expect(response).to have_http_status(:no_content)
      }

      it "Delete Anime" do
        expect{
          delete api_v1_anime_path(@anime), headers:admin_header, as: :json
        }.to change(Anime,:count).by(-1)
      end

    end

    context "with valid token & admin & invalid id" do

      before :each do
        @anime = FactoryBot.create(:anime)
      end

      it {
        delete api_v1_anime_path(1111), headers:admin_header, as: :json
        expect(response).to have_http_status(:not_found)
      }

      it "Delete Anime" do
        expect{
          delete api_v1_anime_path(111), headers:admin_header, as: :json
        }.to change(Anime,:count).by(0)
      end

    end

    context "with valid token" do

      before :each do
        @anime = FactoryBot.create(:anime)
      end

      it {
        delete api_v1_anime_path(@anime), headers:user_header, as: :json
        expect(response).to have_http_status(:unauthorized)
      }

      it "Delete Anime" do
        expect{
          delete api_v1_anime_path(@anime), headers:user_header, as: :json
        }.to change(Anime,:count).by(0)
      end

    end

    context "with valid token & invalid id" do

      before :each do
        @anime = FactoryBot.create(:anime)
      end

      it {
        delete api_v1_anime_path(1111), headers:user_header, as: :json
        expect(response).to have_http_status(:not_found)
      }

      it "Delete Anime" do
        expect{
          delete api_v1_anime_path(@anime), headers:user_header, as: :json
        }.to change(Anime,:count).by(0)
      end

    end

    context "with invalid token" do

      before :each do
        @anime = FactoryBot.create(:anime)
      end

      it {
        delete api_v1_anime_path(@anime), headers:invalid_header, as: :json
        expect(response).to have_http_status(:unauthorized)
      }

      it "Delete Anime" do
        expect{
          delete api_v1_anime_path(@anime), headers:invalid_header, as: :json
        }.to change(Anime,:count).by(0)
      end

    end

    context "with invalid token & invalid id" do

      before :each do
        @anime = FactoryBot.create(:anime)
      end

      it {
        delete api_v1_anime_path(1111), headers:invalid_header, as: :json
        expect(response).to have_http_status(:unauthorized)
      }

      it "Delete Anime" do
        expect{
          delete api_v1_anime_path(@anime), headers:invalid_header, as: :json
        }.to change(Anime,:count).by(0)
      end

    end

  end

  describe "POST /api/v1/animes/add_tags" do

    context "with valid token & admin" do

      before :each do
        @anime = FactoryBot.create(:anime)
        post api_v1_anime_add_tags_path(@anime), headers:admin_header, params:{ anime: tag }, as: :json
      end

      it { expect(response).to have_http_status(:created) }

      it "create to rcontroller" do
        expect{
          post api_v1_anime_add_tags_path(@anime), headers:admin_header, params:{ anime: tag }, as: :json
        }.to change(@anime.tags,:count).by(1)
      end

    end

  end

end
