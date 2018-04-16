require 'rails_helper'

RSpec.describe Team, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:players) }
  it { is_expected.to have_many(:squads) }

  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:name) }
end
