require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_one(:team) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }

  it { is_expected.to define_enum_for(:status).with(newbie: 0, approved: 1, admin: 2) }
end
