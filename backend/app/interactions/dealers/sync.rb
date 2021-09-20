# frozen_string_literal: true

module Dealers
  # Sync synchronizes dealers with third-party service.
  # TODO(roman): if the number of companies is big enough, split the companies
  # array and call the sync interactor wrapped into a job for every chunk to
  # speed up the syncronization.
  class Sync < ActiveInteraction::Base
    interface :client, methods: %i[call]
    time :now

    def execute
      res = client.call
      unless res.success?
        errors.add(:client, 'failed to get companies')
        return
      end

      compose(Dealers::Upsert, now: now, dealers: res.companies)
      compose(Dealers::Delete, before: now)
    end
  end
end
