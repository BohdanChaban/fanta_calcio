class GamesSerializer < ActiveModel::Serializer
  attributes :id, :start_time, :host_id, :host_name, :host_logo, :result,
             :guest_id, :guest_name, :guest_logo, :tour_number, :tour_id

  def host_name
    object.host.name.capitalize
  end

  def host_logo
    object.host.logo
  end

  def guest_name
    object.guest.name.capitalize
  end

  def guest_logo
    object.guest.logo
  end

  def tour_number
    object.tour.number
  end
end
