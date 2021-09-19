# frozen_string_literal: true

# Create dealers.
Dealers::Sync.run!(
  client: CompanyApi::Client.new,
  now: Time.now
)
