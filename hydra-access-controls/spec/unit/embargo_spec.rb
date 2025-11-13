require 'spec_helper'

describe Hydra::AccessControls::Embargo do
  let(:embargo) { described_class.new }

  describe '#active?' do
    context 'when embargo_release_date is not present' do
      it 'returns false' do
        embargo.embargo_release_date = nil
        expect(embargo.active?).to be false
      end
    end

    context 'when embargo_release_date is present' do
      context 'with a future date' do
        it 'returns true' do
          embargo.embargo_release_date = 1.day.from_now
          expect(embargo.active?).to be true
        end
      end

      context 'with a past date' do
        it 'returns false' do
          embargo.embargo_release_date = 2.days.ago
          expect(embargo.active?).to be false
        end
      end

      context 'with today\'s date' do
        it 'returns true when set to today at end of day' do
          embargo.embargo_release_date = Date.today.end_of_day
          expect(embargo.active?).to be true
        end

        it 'returns true when set to today at beginning of day' do
          embargo.embargo_release_date = Date.today.beginning_of_day
          expect(embargo.active?).to be true
        end

        it 'returns true when set to today at noon' do
          embargo.embargo_release_date = Date.today.noon
          expect(embargo.active?).to be true
        end
      end

      context 'with yesterday\'s date' do
        it 'returns false when set to yesterday at end of day' do
          embargo.embargo_release_date = Date.yesterday.end_of_day
          expect(embargo.active?).to be false
        end

        it 'returns false when set to yesterday at beginning of day' do
          embargo.embargo_release_date = Date.yesterday.beginning_of_day
          expect(embargo.active?).to be false
        end
      end

      context 'edge case: exactly at the boundary' do
        it 'returns false when release date equals yesterday end_of_day' do
          boundary_time = Date.yesterday.end_of_day
          embargo.embargo_release_date = boundary_time
          expect(embargo.active?).to be false
        end

        it 'returns true when release date is one second after yesterday end_of_day' do
          boundary_time = Date.yesterday.end_of_day + 1.second
          embargo.embargo_release_date = boundary_time
          expect(embargo.active?).to be true
        end
      end
    end
  end

  describe '#deactivate!' do
    context 'when embargo is active' do
      before do
        embargo.embargo_release_date = 1.day.from_now
        embargo.visibility_during_embargo = 'private'
        embargo.visibility_after_embargo = 'public'
      end

      it 'clears embargo fields and logs history' do
        expect(embargo.active?).to be true
        embargo.deactivate!

        expect(embargo.embargo_release_date).to be_nil
        expect(embargo.visibility_during_embargo).to be_nil
        expect(embargo.visibility_after_embargo).to be_nil
        expect(embargo.embargo_history).to include(a_string_matching(/active embargo was deactivated/))
      end
    end

    context 'when embargo is expired' do
      before do
        embargo.embargo_release_date = 1.day.ago
        embargo.visibility_during_embargo = 'private'
        embargo.visibility_after_embargo = 'public'
      end

      it 'clears embargo fields and logs history' do
        expect(embargo.active?).to be false
        embargo.deactivate!

        expect(embargo.embargo_release_date).to be_nil
        expect(embargo.visibility_during_embargo).to be_nil
        expect(embargo.visibility_after_embargo).to be_nil
        expect(embargo.embargo_history).to include(a_string_matching(/expired embargo was deactivated/))
      end
    end

    context 'when no embargo is set' do
      it 'does nothing' do
        embargo.embargo_release_date = nil
        embargo.deactivate!
        expect(embargo.embargo_history).to be_empty
      end
    end
  end
end