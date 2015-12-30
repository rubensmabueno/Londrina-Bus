class RouteSerializer < ActiveModel::Serializer
  attributes :schedules

  def schedules
    object.schedule.map { |schedule| ScheduleSerializer.new(schedule, root: false) }
  end
end
