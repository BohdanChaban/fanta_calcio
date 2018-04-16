require 'rails_helper'

RSpec.describe Squad, type: :model do
  it { is_expected.to belong_to(:team) }
  it { is_expected.to belong_to(:tour) }
  it { is_expected.to have_many(:members) }

  it { is_expected.to validate_presence_of(:team_id) }
  it { is_expected.to validate_presence_of(:tour_id) }
end
