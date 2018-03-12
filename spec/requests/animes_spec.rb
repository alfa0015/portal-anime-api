require 'rails_helper'

RSpec.describe "Animes", type: :request do

  context "With token valid" do

    describe "GET /api/v1/animes(.:format)" do

      before :each do
        FactoryBot.create_list(:anime,10)
        get api_v1_animes_path, headers:{"Authorization":"bearer #{log_in}","Content-Type":"application/json"}, as: :json
      end

      it{	expect(response).to have_http_status(:ok) }

      it "response with list animes" do
        json = JSON.parse(response.body)
        expect(json.length).to eq(Anime.count)
      end

    end

    describe "GET /api/v1/animes/:id" do

      before :each do
        @anime = FactoryBot.create(:anime)
        get api_v1_anime_path(@anime.id), headers:{"Authorization":"bearer #{log_in}","Content-Type":"application/json"}, as: :json
      end

      it { expect(response).to have_http_status(:ok) }

      it "show post request" do
        json = JSON.parse(response.body)
        expect(json["id"]).to eq(@anime.id)
      end

      it "response with correctly attributes" do
        json = JSON.parse(response.body)
        expect(json.keys).to contain_exactly("id","name","synopsis","sessions","episodes","created_at","updated_at","url")
      end

    end

    describe "POST /api/v1/animes(.:format)" do

      before :each do
        @anime = FactoryBot.build(:anime)
        post api_v1_animes_path, headers:{"Authorization":"bearer #{log_in}","Content-Type":"application/json"}, params:{ anime:@anime }, as: :json
      end

      it { expect(response).to have_http_status(:created) }

      it "create to anime" do
				expect{
					post api_v1_animes_path, headers:{"Authorization":"bearer #{log_in}","Content-Type":"application/json"}, params:{ anime: FactoryBot.build(:anime) }, as: :json
				}.to change(Anime,:count).by(1)
			end

    end

    describe "PATCH /api/v1/animes/:id(.:format)" do

      before :each do
        @anime = FactoryBot.create(:anime)
        patch api_v1_anime_path(@anime.id), headers:{"Authorization":"bearer #{log_in}","Content-Type":"application/json"}, params:{ anime:{name:"new_name name"} }, as: :json
      end

      it { expect(response).to have_http_status(:ok) }

      it "update anime" do
				json = JSON.parse(response.body)
				expect(json["name"]).to eq("new_name name")
			end

    end

    describe "PUT /api/v1/animes/:id(.:format)" do

      before :each do
        @anime = FactoryBot.create(:anime)
        put api_v1_anime_path(@anime.id), headers:{"Authorization":"bearer #{log_in}","Content-Type":"application/json"}, params:{ anime:{name:"new_name name"} }, as: :json
      end

      it { expect(response).to have_http_status(:ok) }

      it "update anime" do
				json = JSON.parse(response.body)
				expect(json["name"]).to eq("new_name name")
			end

    end

    describe "DELETE /api/v1/animes/:id" do

      before :each do
        @anime = FactoryBot.create(:anime)
      end

      it {
				delete api_v1_anime_path(@anime.id), headers:{"Authorization":"bearer #{log_in}","Content-Type":"application/json"}, as: :json
				expect(response).to have_http_status(:no_content)
			}

      it "Delete anime" do
				expect{
					delete api_v1_anime_path(@anime.id), headers:{"Authorization":"bearer #{log_in}","Content-Type":"application/json"}, as: :json
        }.to change(Anime,:count).by(-1)
			end

    end

  end

  context "With token invalid" do

    describe "GET /api/v1/animes(.:format)" do

      before :each do
        FactoryBot.create_list(:anime,10)
        get api_v1_animes_path, as: :json
      end

      it{	expect(response).to have_http_status(:ok) }

      it "response with list animes" do
        json = JSON.parse(response.body)
        expect(json.length).to eq(Anime.count)
      end

    end

    describe "GET /api/v1/animes/:id" do

      before :each do
        @anime = FactoryBot.create(:anime)
        get api_v1_anime_path(@anime.id), as: :json
      end

      it { expect(response).to have_http_status(:ok) }

      it "show post request" do
        json = JSON.parse(response.body)
        expect(json["id"]).to eq(@anime.id)
      end

      it "response with correctly attributes" do
        json = JSON.parse(response.body)
        expect(json.keys).to contain_exactly("id","name","synopsis","sessions","episodes","created_at","updated_at","url")
      end

    end

    describe "POST /api/v1/animes(.:format)" do

      before :each do
        @anime = FactoryBot.build(:anime)
        post api_v1_animes_path, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "create to anime" do
				expect{
					post api_v1_animes_path, params:{ anime: FactoryBot.build(:anime) }, as: :json
				}.to change(Anime,:count).by(0)
			end

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    describe "PATCH /api/v1/animes/:id(.:format)" do

      before :each do
        @anime = FactoryBot.create(:anime)
        patch api_v1_anime_path(@anime.id), params:{ anime:{name:"new_name name"} }, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    describe "PUT /api/v1/animes/:id(.:format)" do

      before :each do
        @anime = FactoryBot.create(:anime)
        put api_v1_anime_path(@anime.id), params:{ anime:{name:"new_name name"} }, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    describe "DELETE /api/v1/animes/:id" do

      before :each do
        @anime = FactoryBot.create(:anime)
      end

      it {
				delete api_v1_anime_path(@anime.id), as: :json
				expect(response).to have_http_status(:unauthorized)
			}

      it "Delete anime" do
				expect{
					delete api_v1_anime_path(@anime.id), as: :json
        }.to change(Anime,:count).by(0)
			end

      it "responds with error" do
				delete api_v1_anime_path(@anime.id), as: :json
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
			end

    end

  end

end
