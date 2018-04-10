require 'rails_helper'

RSpec.describe Tour, type: :model do
  it { is_expected.to have_many(:games) }

  it { is_expected.to validate_presence_of(:base_date) }
  it { is_expected.to validate_presence_of(:number) }

  it 'number should be in range from 1 to 38' do
    is_expected.to_not allow_value(111).for(:number).on(:personal_information)
  end

  context 'with duplicated number provided' do
    let(:tour1) { described_class.create }
    let(:tour2) { described_class.new(number: tour1.number) }

    it 'tour is invalid' do
      expect(tour2.valid?).to be false
    end
  end
end
