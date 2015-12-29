class ScheduleSerializer < ActiveModel::Serializer
  attributes :departure, :arrival, :path

  def departure
    object['departure']
  end

  def arrival
    object['arrival']
  end

  def path
    object['path']
  end
end
