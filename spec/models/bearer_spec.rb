require 'rails_helper'

describe Bearer, type: :model do
  it { is_expected.to validate_presence_of :name }

  describe '#name' do
    it 'validates name uniqueness case insensitive' do
      bearer1 = create(:bearer, name: 'Foo Bar')

      bearer2 = build(:bearer, name: 'fOO bAr')

      expect(bearer2).to be_invalid
      expect(bearer2.errors[:name]).to include('has already been taken')
    end
  end
end
