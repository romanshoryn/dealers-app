# frozen_string_literal: true

module CompanyApi
  # Response defines response of the api call.
  class Response
    OK_STATUS = 'OK'

    attr_reader :status, :companies

    def initialize(status:, companies:)
      @status = status
      @companies = companies
    end

    def success?
      @status == OK_STATUS
    end
  end

  # Client interacts with the company api.
  class Client
    include HTTParty
    base_uri ENV['COMPANY_API_URL']

    def initialize(
      seed = ENV['COMPANY_API_SEED'],
      quantity = ENV['COMPANY_API_QUANTITY']
    )
      @options = { query: { _seed: seed, _quantity: quantity } }
    end

    def call
      res = self.class.get('/', @options)

      companies = res['data']&.reduce([]) do |cs, row|
        cs << Mappers::CompanyMapper.call(row)
      end

      Response.new(
        # TODO(roman): define status mapper.
        status: res['status'],
        companies: companies
      )
    end
  end
end
