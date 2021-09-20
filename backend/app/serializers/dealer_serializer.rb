# frozen_string_literal: true

# DealerSerializer defines json representation of Dealer.
class DealerSerializer < ActiveModel::Serializer
  attributes(
    :name, :phone, :street, :city, :zipcode,
    :country, :latitude, :longitude
  )
end
