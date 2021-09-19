# frozen_string_literal: true

# Dealer defines dealer model.
class Dealer < ApplicationRecord
  scope :updated_before, ->(before) { where('updated_at < ?', before.iso8601) }
end
