require 'rails_helper'

RSpec.describe "Dealers", type: :request do
  before(:each) do
    VCR.insert_cassette "dealers", :record => :new_episodes
  end
  
  after(:each) do
    VCR.eject_cassette
  end

  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/dealers"

      expect(response).to have_http_status(:success)
    end
  end
end