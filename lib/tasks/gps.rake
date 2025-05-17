
namespace :gps do
  desc "Save GPS tracking data to the database"
  task track: [ :environment ] do
    gpsd = GpsdClient::Gpsd.new()
    gpsd.start

    if gpsd.started?
      while true
        pos = gpsd.get_position
        if pos[:speed] > 0.1
          puts "Saving GPS data: #{pos[:lat]}, #{pos[:lon]}, #{pos[:altMSL]}"
          GPS::Point.create(
            latitude: pos[:lat],
            longitude: pos[:lon],
            created_at: pos[:time],
            # speed: pos[:speed],
            accuracy: pos[:eph],
            altitude: pos[:altMSL],
          )
        else
          puts "No significant movement detected. Speed: #{pos[:speed]}"
        end
        sleep 5 # Sleep for 5 seconds before the next check
      end
    end
    # To stop polling the daemon
    gpsd.stop()
  end
end
