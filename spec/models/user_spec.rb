require 'rails_helper'

describe User do
  it { is_expected.to have_many(:points) }

  describe '#valid?' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }

    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_length_of(:username).is_at_least(2).is_at_most(32) }

    it { is_expected.to validate_presence_of(:email) }

    context 'when a user already exists' do
      before { create(:user) }

      it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
      it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    end
  end

  describe '.by_total_points' do
    it 'returns users in order of highest-to-lowest total points' do
      user_med   = create(:user_with_points, :total => 500, :points => 2)
      user_low   = create(:user_with_points, :total => 200, :points => 2)
      user_high  = create(:user_with_points, :total => 800, :points => 2)

      expect(User.by_total_points).to eq [user_high, user_med, user_low]
    end
  end

  describe '#total_points' do
    let(:user) { create(:user_with_points, :total => 500, :points => 2) }

    it 'returns the total points for the user' do
      expect(user.total_points).to eq 500
    end
  end

  describe '#full_name' do
    let(:user) { build(:user) }

    it 'returns both the first and last names in a single string' do
      user.first_name = 'John'
      user.last_name  = 'Doe'

      expect(user.full_name).to eq 'John Doe'
    end
  end

  describe '.page' do
    before do
      36.times do 
        create(:user)
      end
    end

    it 'returns users by the number of pages' do
      expect(User.page(1).count).to eq 10
      expect(User.page(3).count).to eq 10
      expect(User.page(4).count).to eq 6
    end

    it 'returns nothing if the page count is too high' do
      expect(User.page(5).count).to eq 0
    end

    it 'return the first page if the page count is invalid' do
      expect(User.page(0)).to eq User.page(1)
      expect(User.page).to eq User.page(1)
      expect(User.page('n')).to eq User.page(1)
    end
  end
end
