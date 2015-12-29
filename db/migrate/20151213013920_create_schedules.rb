class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.text :schedule, allow_nil: false

      t.timestamps null: false
    end
  end
end
