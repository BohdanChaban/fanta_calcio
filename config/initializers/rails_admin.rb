RailsAdmin.config do |config|

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
  end

  config.model 'Club' do
    list do
      field :id
      field :name
      field :points
      field :position
    end

    edit do
      field :name
    end
  end

  config.model 'Game' do
    list do
      field :id
      field :tour do
        pretty_value do
          value.try(:number)
        end
      end
      field :host
      field :result
      field :guest
      field :start_time
    end
  end

  config.model 'Member' do
    list do
      field :id
      field :player
      field :total_score
      field :status
      field :appearance
      field :squad
    end
  end

  config.model 'Player' do
    list do
      field :id
      field :name
      field :club
      field :position
      field :init_price
      field :actual_price
    end
  end

  config.model 'Squad' do
    list do
      field :id
      field :team
      field :tour
      field :total_score
      field :goals
      field :points
    end
  end

  config.model 'Team' do
    list do
      field :id
      field :name
      field :user
    end
  end

  config.model 'Tour' do
    list do
      field :id
      field :number
      field :base_date
      field :season do
        pretty_value do
          value.try(:years)
        end
      end
      field :squads
    end
  end

  config.model 'User' do
    list do
      field :id
      field :email
      field :first_name
      field :last_name
      field :team
      field :status
    end

    edit do
      field :first_name
      field :last_name
      field :status
    end
  end
end
