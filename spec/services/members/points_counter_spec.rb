require 'rails_helper'

RSpec.describe Members::PointsCounter do
  describe '#call' do
    let(:name) { 'BUFFON' }
    let(:clean_sheet) { true }
    let(:member_stats) do
      Nokogiri::HTML(RestClient.get(Api::Url.results)).css('#rounded-corner tbody')
              .xpath("//td[contains(text(), \"#{name}\")]").first.parent.children
    end

    let(:subject) { described_class.call(member_stats, clean_sheet) }

    context 'when player have points' do
      it 'returns member results' do
        expect(subject).to include(:total_score, :points, :scored_goals, :scored_penalties,
                                   :conceded_goals, :missed_penalties, :assists, :clean_sheets,
                                   :yellow_cards, :red_cards, :own_goals)
      end
    end

    context 'when player does not have points' do
      before do
        allow_any_instance_of(described_class).to receive(:points).and_return(0)
      end

      it 'returns empty hash' do
        expect(subject).to eq({})
      end
    end
  end
end
