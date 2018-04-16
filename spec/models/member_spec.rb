require 'rails_helper'

RSpec.describe Member, type: :model do
  it { is_expected.to belong_to(:squad) }
  it { is_expected.to belong_to(:player) }

  it { is_expected.to validate_presence_of(:squad_id) }
  it { is_expected.to validate_presence_of(:player_id) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to validate_presence_of(:total_score) }
  it { is_expected.to validate_presence_of(:points) }
  it { is_expected.to validate_presence_of(:scored_goals) }
  it { is_expected.to validate_presence_of(:scored_penalties) }
  it { is_expected.to validate_presence_of(:conceded_goals) }
  it { is_expected.to validate_presence_of(:missed_penalties) }
  it { is_expected.to validate_presence_of(:assists) }
  it { is_expected.to validate_presence_of(:clean_sheets) }
  it { is_expected.to validate_presence_of(:yellow_cards) }
  it { is_expected.to validate_presence_of(:red_cards) }
  it { is_expected.to validate_presence_of(:own_goals) }
end
