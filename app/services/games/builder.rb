module Games
  module Builder
    HOST_CLUB_NODE_NO = 3
    GUEST_CLUB_NODE_NO = 5

    def start_time
      start_time = game_info.children[1].children[1].children[1].text
      Time.strptime(start_time, '%d/%m/%Y %H:%M')
    end

    def result
      host_result + '-' + guest_result
    end

    def host
      Club.find_by(name: club_name(HOST_CLUB_NODE_NO))
    end

    def guest
      Club.find_by(name: club_name(GUEST_CLUB_NODE_NO))
    end

    private

    def host_result
      game_info.children[HOST_CLUB_NODE_NO].children[3].text
    end

    def guest_result
      game_info.children[GUEST_CLUB_NODE_NO].children[1].text
    end

    def club_name(element)
      name = game_info.children[element].children[7].text.downcase

      case name
      when 'chievoverona'
        'chievo'
      when 'hellas verona'
        'verona'
      else
        name
      end
    end
  end
end
