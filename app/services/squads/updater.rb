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

      # update_squad

      # temporary
      true
    end

    private

    def update_members
      @members.each do |member|
        Members::Updater.call(member)
      end
    end

    def update_squad
      squad.update(squad_params)
    end

    def squad_params
      {
        total_score: total_score,
        goals: goals
      }
    end

    def defence_bonus
      # related to average score of all squad defenders
    end

    def goals
      # related to total_score
    end

    def total_score
      # scores of all members + defence_bonus
    end
  end
end
