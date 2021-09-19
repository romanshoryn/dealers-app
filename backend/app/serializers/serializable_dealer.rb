# frozen_string_literal: true

# SerializableDealer defines json representation of Dealer.
class SerializableDealer < JSONAPI::Serializable::Resource
  type 'dealers'

  attributes(
    :name, :phone, :street, :city, :zipcode,
    :country, :latitude, :longitude
  )
end
