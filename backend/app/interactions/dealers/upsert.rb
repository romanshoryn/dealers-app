# frozen_string_literal: true

module Dealers
  # Upsert creates or updates dealers.
  class Upsert < ActiveInteraction::Base
    interface :generator, methods: %i[uuid], default: SecureRandom

    time :now
    array :dealers

    def execute
      ActiveRecord::Base.connection.execute(
        <<-SQL
          INSERT INTO dealers (
            id, name, phone, street, city, zipcode,
            country, latitude, longitude, created_at, updated_at
          )
          VALUES #{values}
          ON CONFLICT (REPLACE(LOWER(name), ' ', ''), latitude, longitude)
          DO
          UPDATE SET
            name       = EXCLUDED.name,
            phone      = EXCLUDED.phone,
            street     = EXCLUDED.street,
            city       = EXCLUDED.city,
            zipcode    = EXCLUDED.zipcode,
            country    = EXCLUDED.country,
            latitude   = EXCLUDED.latitude,
            longitude  = EXCLUDED.longitude,
            updated_at = '#{now.iso8601}'
        SQL
      )
    end

    private

    def values
      dealers.map do |d|
        vals = [
          generator.uuid,
          d.name,
          d.phone,
          d.address&.street,
          d.address&.city,
          d.address&.zipcode,
          d.address&.country,
          d.address&.latitude,
          d.address&.longitude,
          now.iso8601,
          now.iso8601
        ].map do |val|
          case val
          when String then ActiveRecord::Base.connection.quote(val)
          when NilClass then ''
          else val
          end
        end.join(',')

        "(#{vals})"
      end.join(', ')
    end
  end
end
