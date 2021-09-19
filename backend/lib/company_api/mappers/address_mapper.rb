# frozen_string_literal: true

module CompanyApi
  module Mappers
    # AddressMapper converts json data into Address model.
    class AddressMapper
      def self.call(data)
        Models::Address.new(
          street: data['street'],
          city: data['city'],
          zipcode: data['zipcode'],
          country: data['country'],
          latitude: data['latitude'],
          longitude: data['longitude']
        )
      end
    end
  end
end
