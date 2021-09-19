# frozen_string_literal: true

module CompanyApi
  module Models
    # Address keeps company's address data.
    class Address
      attr_reader :street, :city, :zipcode, :country, :latitude, :longitude

      def initialize(args)
        @street    = args[:street]
        @city      = args[:city]
        @zipcode   = args[:zipcode]
        @country   = args[:country]
        @latitude  = args[:latitude]
        @longitude = args[:longitude]
      end
    end
  end
end
