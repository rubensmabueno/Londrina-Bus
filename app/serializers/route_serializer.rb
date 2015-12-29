class RouteSerializer < ActiveModel::Serializer
  attributes :schedules

  def schedules
    JSON.parse(object.schedule).map { |schedule| ScheduleSerializer.new(schedule, root: false) }
  end
end
