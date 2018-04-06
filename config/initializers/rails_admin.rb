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

  config.model 'User' do
    edit do
      field :first_name
      field :last_name
      field :status
    end
  end

  config.model 'Club' do
    edit do
      field :name
    end
  end
end
