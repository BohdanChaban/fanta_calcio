module Members
  class Updater
    def self.call(member)
      new(member).call
    end

    attr_accessor :member, :name

    def initialize(member)
      @member = member
      @name = nickname
    end

    def call
      return unless member_row.present?

      member.update(params_hash)
    end

    private

    def params_hash
      PointsCounter.call(member_stats, member.clean_sheet?)
    end

    def member_stats
      member_row.parent.children
    end

    def member_row
      html_page.css('#rounded-corner tbody tr').xpath("//td[contains(text(), \"#{name}\")]").first
    end

    def nickname
      mapping = YAML.safe_load(IO.read(Rails.root.join('config', 'names_voti_mapping.yml')))[member.name]
      mapping ? mapping : member.name
    end

    def html_page
      Nokogiri::HTML(
        RestClient.get(Api::Url.results)
      )
    end
  end
end
