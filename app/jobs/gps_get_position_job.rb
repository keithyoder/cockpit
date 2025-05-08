require "sidekiq"

class GPSGetPositionJob < ApplicationJob
  sidekiq_options retry: 0
  queue_as :default

  def perform(*args)
    gps = NeoM9n.new
    gps.read
    position = gps.position
    if position.present?
      GPS::Point.create(
        latitude: position[:latitude],
        longitude: position[:longitude],
        altitude: position[:altitude],
        fix_quality: position[:fix_quality],
        satellites: position[:satellites],
        accuracy: position[:horizontal_dilution],
        created_at: position[:time]
      )
    end
    GPSGetPositionJob.set(wait: 10.seconds).perform_later
  end
end
