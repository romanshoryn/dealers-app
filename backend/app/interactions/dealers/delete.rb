# frozen_string_literal: true

module Dealers
  # Delete deletes dealers and their relations with updated_at
  # before specific time.
  class Delete < ActiveInteraction::Base
    time :before

    def execute
      scope = Dealer.updated_before(before)
      count = scope.count

      Rails.logger.info("Dealers to be deleted: #{count}")
      unless scope.destroy_all
        Rails.logger.error('Failed to delete dealers')
        return 0
      end

      count
    end
  end
end
