class Day
  DAYS = {
      weekday: 1,
      saturday: 2,
      sunday: 3,
  }

  def self.all
    DAYS.values
  end

  def self.weekday
    DAYS[:weekday]
  end

  def self.saturday
    DAYS[:saturday]
  end

  def self.sunday
    DAYS[:sunday]
  end
end