module DashboardHelper
  FULL_BATTERY = 12.88
  EMPTY_BATTERY = 11.80

  def battery_percentage(voltage)
    range = FULL_BATTERY - EMPTY_BATTERY
    percentage = 100 - ((FULL_BATTERY - voltage) / range) * 100

    return 0 if percentage < 0

    percentage
  end
end
