class DealersController < ApplicationController
  require 'httparty'

  def index
    Dealer.delete_all
    
    response = HTTParty.get('https://fakerapi.it/api/v1/companies?_seed=1&_quantity=200')

    response.parsed_response['data'].each{|dealer_info|
      address = dealer_info['addresses'][0]
      Dealer.create(
        name: dealer_info['name'],
        phone: dealer_info['phone'],
        street: address['street'],
        city: address['city'],
        zipcode: address['zipcode'],
        country: address['country'],
        latitude: address['latitude'],
        longitude: address['longitude']
        )
    }
    
    render json: Dealer.all
  end
end