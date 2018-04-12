module Teams
  class TransferValidator
    MAX_TEAM_BY_POSITIONS = {
      P: 3,
      D: 8,
      C: 8,
      A: 6
    }.freeze
    MAX_TEAM_PLAYERS = 25

    def self.call(team, player)
      new(team, player).call
    end

    attr_accessor :team, :player

    def initialize(team, player)
      @team = team
      @player = player
    end

    def call
      free_place? && position_available?
    end

    private

    def position_available?
      players.where(position: position).count < MAX_TEAM_BY_POSITIONS[position.to_sym]
    end

    def free_place?
      players.count < MAX_TEAM_PLAYERS
    end

    def position
      player.position
    end

    def players
      team.players
    end
  end
end
