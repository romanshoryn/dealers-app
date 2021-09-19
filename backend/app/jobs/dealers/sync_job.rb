# frozen_string_literal: true

module Dealers
  # SyncJob synchronizes dealers with third-party service.
  class SyncJob < ApplicationJob
    sidekiq_options queue: 'dealers'

    def perform
      Dealers::Sync.run!(
        client: CompanyApi::Client.new,
        now: Time.now
      )
    end
  end
end
