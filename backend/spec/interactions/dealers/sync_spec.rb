# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dealers::Sync do
  describe '#run!' do
    def run
      Dealers::Sync.run!(
        client: CompanyApi::Client.new(1, 10),
        now: now + 1.day
      )
    end

    let!(:now) { Time.now }

    before(:each) { VCR.insert_cassette('companies') }
    after(:each) { VCR.eject_cassette }

    context 'with a dealer in db' do
      let!(:dealer) do
        Dealer.create(
          id: SecureRandom.uuid,
          name: 'Ebert and Sons',
          phone: '+2100901518715',
          street: '993 Prosacco Wells',
          city: 'Gordonside',
          zipcode: '84631',
          country: 'Iraq',
          latitude: -32.350944,
          longitude: 8.837339,
          created_at: now,
          updated_at: now
        )
      end

      context 'when name is the same but different case' do
        before { dealer.update(name: 'ebErt    and SonS') }
        before { run }

        it { expect(Dealer.count).to eq 10 }
        it { expect(dealer.reload.name).to eq 'Ebert and Sons' }
      end

      context 'when name is changed' do
        before { dealer.update(name: 'Ebert and Sons Test') }
        before { run }

        it { expect(Dealer.count).to eq 10 }
        it { expect(Dealer.find_by(id: dealer.id)).to be_nil }
      end

      context 'when geo is changed' do
        before { dealer.update(latitude: 32.350944) }
        before { run }

        it { expect(Dealer.count).to eq 10 }
        it { expect(Dealer.find_by(id: dealer.id)).to be_nil }
      end

      context 'when zipcode is changed' do
        before { dealer.update(zipcode: '1111') }
        before { run }

        it { expect(Dealer.count).to eq 10 }
        it { expect(dealer.reload.zipcode).to eq '84631' }
      end
    end

    context 'without any dealers in db' do
      before { run }

      it { expect(Dealer.count).to eq 10 }
    end
  end
end
