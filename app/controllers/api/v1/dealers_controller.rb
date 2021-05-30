module API
  module V1
    class DealersController < ApplicationController
      require 'httparty'

      def index
        expires_in 30.minutes, :public => true
        
        fetch_command = FetchDealers.call
        
        raise fetch_command.errors if not fetch_command.success?
        
        render json: fetch_command.result
      end
    end
  end
end