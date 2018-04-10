require 'rails_helper'

RSpec.describe Game, type: :model do
  it { is_expected.to belong_to(:tour) }
  it { is_expected.to belong_to(:host) }
  it { is_expected.to belong_to(:guest) }

  it { is_expected.to validate_presence_of(:tour) }
  it { is_expected.to validate_presence_of(:host) }
  it { is_expected.to validate_presence_of(:guest) }
  it { is_expected.to validate_presence_of(:start_time) }
end
