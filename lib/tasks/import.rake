namespace :import do
  desc 'Import Lines, Routes, Stops and Schedules from TCGL Server'
  task all: :environment do
    TCGL::Models::Line.all.each do |line|
      line_model = Line.where(code: line.code).first_or_initialize(title: line.title)

      routes = []

      Day.all.each do |day|
        line.stops(day_id: day).each do |origin|
          origin_model = Stop.where(code: origin.code).first_or_initialize(title: origin.title)

          line.stops(day_id: day).each do |destination|
            destination_model = Stop.where(code: destination.code).first_or_initialize(title: destination.title)

            schedules = line.schedules(origin_stop_id: origin_model.code, destination_stop_id: destination_model.code, day_id: day).map do |schedule|
              { departure: schedule.departure, arrival: schedule.arrival, path: schedule.path }
            end

            next unless schedules.any?

            schedule_model = Schedule.new(schedule: schedules)
            routes << Route.new(origin: origin_model, destination: destination_model, day: day, schedule: schedule_model)
          end
        end
      end

      line_model.routes = routes
      line_model.save!
    end
  end
end
