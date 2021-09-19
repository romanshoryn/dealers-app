# frozen_string_literal: true

module CompanyApi
  module Models
    # Company keeps company's data.
    class Company
      attr_reader :name, :phone, :address

      def initialize(args)
        @name    = args[:name]
        @phone   = args[:phone]
        @address = args[:address]
      end
    end
  end
end
