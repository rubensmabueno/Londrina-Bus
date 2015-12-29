namespace :import do
  desc 'Import Lines, Routes, Stops and Schedules from TCGL Server'
  task all: :environment do
    TCGL::Models::Line.all.each do |line|
      line_model = Line.where(code: line.code).first_or_create(title: line.title)

      Day.all.each do |day|
        line.stops(day_id: day).each do |origin|
          origin_model = Stop.where(code: origin.code).first_or_create(title: origin.title)

          line.stops(day_id: day).each do |destination|
            destination_model = Stop.where(code: destination.code).first_or_create(title: destination.title)

            schedules = line.schedules(origin_stop_id: origin_model.code, destination_stop_id: destination_model.code, day_id: day).map do |schedule|
              { departure: schedule.departure, arrival: schedule.arrival, path: schedule.path }
            end

            next unless schedules.any?

            Route.where(
              origin_id: origin_model.id,
              destination_id: destination_model.id,
              line_id: line_model.id,
              day: day
            ).first_or_create(schedule: schedules.to_json)
          end
        end
      end
    end
  end
end
