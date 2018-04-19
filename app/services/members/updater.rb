module Members
  class Updater
    def self.call(member)
      new(member).call
    end

    attr_accessor :member, :name

    def initialize(member)
      @member = member
      @name = @member.player.name
    end

    def call
      return unless member_row.present?

      member.update(params_hash)
    end

    private

    def params_hash
      PointsCounter.call(member_stats, @member.player.position)
    end

    def member_stats
      # TODO: add raise
      # raise "Member #{name} not found" unless member_row.present?
      member_row.parent.children
    end

    def member_row
      html_page.css('#rounded-corner tbody tr').xpath("//td[contains(text(), \"#{name}\")]").first
    end

    def html_page
      Nokogiri::HTML(
        RestClient.get(Api::Url.results)
      )
    end
  end
end
