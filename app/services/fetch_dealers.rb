class FetchDealers
  require 'httparty'
  prepend SimpleCommand
  
  def map_to_dealer dealer_info
    address = dealer_info['addresses'][0]

    Dealer.new(
      name: dealer_info['name'],
      phone: dealer_info['phone'],
      street: address['street'],
      city: address['city'],
      zipcode: address['zipcode'],
      country: address['country'],
      latitude: address['latitude'],
      longitude: address['longitude']
      )
  end

  def call
    response = HTTParty.get('https://fakerapi.it/api/v1/companies?_seed=1&_quantity=200')

    if response.code == 200
      Dealer.delete_all

      response.parsed_response['data'].each{|dealer_info|
        dealer = map_to_dealer(dealer_info)
        dealer.save()
      }
    end

    Dealer.all
  end
end