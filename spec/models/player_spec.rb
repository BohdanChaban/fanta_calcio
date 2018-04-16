require 'rails_helper'

RSpec.describe Player, type: :model do
  it { is_expected.to belong_to(:club) }
  it { is_expected.to belong_to(:team) }
  it { is_expected.to have_many(:members) }

  it { is_expected.to validate_presence_of(:club_id) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:position) }
  it { is_expected.to validate_presence_of(:init_price) }
  it { is_expected.to validate_presence_of(:actual_price) }
end
