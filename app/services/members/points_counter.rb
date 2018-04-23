module Members
  class PointsCounter
    GOAL_SCORED_STR = 'gf'.freeze
    GOAL_CONCEDED_STR = 'gs'.freeze
    YELLOW_CARD_STR = 'giallo'.freeze
    RED_CARD_STR = 'rossos'.freeze
    SAVED_PENALTY_STR = 'rp'.freeze
    MISSED_PENALTY_STR = 'rs'.freeze
    OWN_GOAL_STR = 'autog'.freeze
    ASSIST_STR = 'assis'.freeze

    def self.call(member_stats, clean_sheet)
      new(member_stats, clean_sheet).call
    end

    attr_accessor :member_stats, :clean_sheet

    def initialize(member_stats, clean_sheet)
      @member_stats = member_stats
      @clean_sheet = clean_sheet
    end

    def call
      return {} if points.zero?

      {
        total_score: total_score,
        points: points,
        scored_goals: scored_goals,
        scored_penalties: scored_penalties,
        conceded_goals: conceded_goals,
        missed_penalties: missed_penalties,
        assists: assists,
        clean_sheets: clean_sheets,
        yellow_cards: yellow_cards,
        red_cards: red_cards,
        own_goals: own_goals
      }
    end

    private

    def total_score
      points + bonuses - maluses
    end

    def points
      member_stats[5].text.slice(0, 3).to_f
    end

    def scored_goals
      bonus_count(GOAL_SCORED_STR, 7) + saved_penalties
    end

    def scored_penalties
      # TODO: bonus_count(??, ??)
      0
    end

    def conceded_goals
      bonus_count(GOAL_CONCEDED_STR, 7)
    end

    def missed_penalties
      bonus_count(MISSED_PENALTY_STR, 11)
    end

    def saved_penalties
      bonus_count(SAVED_PENALTY_STR, 11)
    end

    def assists
      bonus_count(ASSIST_STR, 15)
    end

    def clean_sheets
      clean_sheet ? 1 : 0
    end

    def yellow_cards
      bonus_count(YELLOW_CARD_STR, 9)
    end

    def red_cards
      bonus_count(RED_CARD_STR, 9)
    end

    def own_goals
      bonus_count(OWN_GOAL_STR, 13)
    end

    def bonuses
      3 * scored_goals + 2 * scored_penalties + assists + clean_sheets
    end

    def maluses
      2 * conceded_goals + 3 * missed_penalties + 0.5 * yellow_cards + red_cards + 2 * own_goals
    end

    def bonus_count(bonus_str, bonus_position)
      bonus = 0
      member_stats[bonus_position].children.to_a.each do |node|
        bonus += 1 if bonus_present?(node.attributes['src'], bonus_str)
      end
      bonus
    end

    def bonus_present?(node_src, value)
      return unless node_src
      node_src.value.include?(value)
    end
  end
end
