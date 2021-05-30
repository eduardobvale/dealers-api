require 'rails_helper'

RSpec.describe FetchDealers do
  context "when 3rd party API is responding" do
    it "saves all records in place" do
      # arrange
      VCR.insert_cassette "dealers", :record => :new_episodes

      # act
      fetch_command = FetchDealers.call
      
      # assert
      expect(fetch_command.result).to eq(Dealer.all)
      VCR.eject_cassette
    end
  end

  context "when 3rd party API is not responding" do
    it "keep old records in place" do
      # arrange
      stub_request(:get, ENV['DEALERS_API_SOURCE'])
        .to_return(status: [500, "Internal Server Error"])
      sample = Dealer.create()
      
      # act
      fetch_command = FetchDealers.call

      # assert
      expect(fetch_command.result).to eq([sample])
    end
  end
end