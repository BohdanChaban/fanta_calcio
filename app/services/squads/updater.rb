module Squads
  class Updater
    def self.call(squad)
      new(squad).call
    end

    attr_accessor :squad, :members

    def initialize(squad)
      @squad = squad
      @members = @squad.members
    end

    def call
      update_members

      set_played_members

      update_squad
    end

    private

    def update_members
      members.each do |member|
        Members::Updater.call(member)
      end
    end

    def set_played_members
      members.main_with_points.update_all(appearance: 1)
      members.missed.each do |member|
        member.update(appearance: 2)
        members.alternate(member.position).first&.update(appearance: 1)
      end
    end

    def update_squad
      squad.update(
        total_score: total_score,
        goals: goals
      )
    end

    def total_score
      members_points + defence_bonus
    end

    def members_points
      points = 0
      members.played.each do |member|
        points += member.total_score
      end
      points
    end

    def defence_bonus
      points = 0
      defenders = members.played_defenders.each do |member|
        points += member.points
      end
      average_point = points / defenders.count

      return 1 if average_point < 6
      ((average_point - 5.5) / 0.25).to_i
    end

    def goals
      return 0 if total_score < 66
      ((total_score - 60) / 6).to_i
    end
  end
end
