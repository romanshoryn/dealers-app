# frozen_string_literal: true

module CompanyApi
  module Mappers
    # CompanyMapper converts json data into Company model.
    class CompanyMapper
      def self.call(data)
        addresses = Array(data['addresses'])
  
        Models::Company.new(
          name: data['name'],
          phone: data['phone'],
          address: addresses.count > 0 ? AddressMapper.call(addresses[0]) : nil
        )
      end
    end
  end
end
