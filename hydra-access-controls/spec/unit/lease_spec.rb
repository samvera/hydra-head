require 'spec_helper'

describe Hydra::AccessControls::Lease do
  let(:lease) { described_class.new }

  describe '#active?' do
    context 'when lease_expiration_date is not present' do
      it 'returns false' do
        lease.lease_expiration_date = nil
        expect(lease.active?).to be false
      end
    end

    context 'when lease_expiration_date is present' do
      context 'with a future date' do
        it 'returns true' do
          lease.lease_expiration_date = 1.day.from_now
          expect(lease.active?).to be true
        end
      end

      context 'with a past date' do
        it 'returns false' do
          lease.lease_expiration_date = 2.days.ago
          expect(lease.active?).to be false
        end
      end

      context 'with today\'s date' do
        it 'returns true when set to today at end of day' do
          lease.lease_expiration_date = Date.today.end_of_day
          expect(lease.active?).to be true
        end

        it 'returns true when set to today at beginning of day' do
          lease.lease_expiration_date = Date.today.beginning_of_day
          expect(lease.active?).to be true
        end

        it 'returns true when set to today at noon' do
          lease.lease_expiration_date = Date.today.noon
          expect(lease.active?).to be true
        end
      end

      context 'with yesterday\'s date' do
        it 'returns false when set to yesterday at end of day' do
          lease.lease_expiration_date = Date.yesterday.end_of_day
          expect(lease.active?).to be false
        end

        it 'returns false when set to yesterday at beginning of day' do
          lease.lease_expiration_date = Date.yesterday.beginning_of_day
          expect(lease.active?).to be false
        end
      end

      context 'edge case: exactly at the boundary' do
        it 'returns false when expiration date equals today end_of_day' do
          boundary_time = Date.today.end_of_day
          lease.lease_expiration_date = boundary_time
          expect(lease.active?).to be false
        end

        it 'returns true when expiration date is one second after today end_of_day' do
          boundary_time = Date.today.end_of_day + 1.second
          lease.lease_expiration_date = boundary_time
          expect(lease.active?).to be true
        end
      end
    end
  end

  describe '#deactivate!' do
    context 'when lease is active' do
      before do
        lease.lease_expiration_date = 1.day.from_now
        lease.visibility_during_lease = 'public'
        lease.visibility_after_lease = 'private'
      end

      it 'clears lease fields and logs history' do
        expect(lease.active?).to be true
        lease.deactivate!

        expect(lease.lease_expiration_date).to be_nil
        expect(lease.visibility_during_lease).to be_nil
        expect(lease.visibility_after_lease).to be_nil
        expect(lease.lease_history).to include(a_string_matching(/active lease was deactivated/))
      end
    end

    context 'when lease is expired' do
      before do
        lease.lease_expiration_date = 1.day.ago
        lease.visibility_during_lease = 'public'
        lease.visibility_after_lease = 'private'
      end

      it 'clears lease fields and logs history' do
        expect(lease.active?).to be false
        lease.deactivate!

        expect(lease.lease_expiration_date).to be_nil
        expect(lease.visibility_during_lease).to be_nil
        expect(lease.visibility_after_lease).to be_nil
        expect(lease.lease_history).to include(a_string_matching(/expired lease was deactivated/))
      end
    end

    context 'when no lease is set' do
      it 'does nothing' do
        lease.lease_expiration_date = nil
        lease.deactivate!
        expect(lease.lease_history).to be_empty
      end
    end
  end
end