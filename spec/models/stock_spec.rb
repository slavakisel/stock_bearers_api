require 'rails_helper'

describe Stock, type: :model do
  it { is_expected.to validate_presence_of :name }

  describe '#name' do
    it 'validates name uniqueness case insensitive' do
      stock1 = create(:stock, name: 'Foo Bar')

      stock2 = build(:stock, name: 'fOO bAr')

      expect(stock2).to be_invalid
      expect(stock2.errors[:name]).to include('has already been taken')
    end
  end
end
