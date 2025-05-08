class NeoM9n
  def initialize
    @decoder =  NMEAPlus::Decoder.new
  end

  def read
    @decoded = nil
    @messages = UART.open("/dev/tty.usbmodem1101", 115200) { |port| port.read.split }
  end

  def decoded
    @decoded ||= @messages&.map do |message|
      begin
        @decoder.parse(message)
      rescue Racc::ParseError => e
        puts "Parse error: #{e.message}"
        nil
      end
    end
  end

  def position
    message = decoded.find { |m| m.instance_of?(NMEAPlus::Message::NMEA::GGA) }
    return if message.blank?
    {
      latitude: message.latitude.to_f,
      longitude: message.longitude.to_f,
      altitude: message.altitude.to_f,
      altitude_units: message.altitude_units,
      fix_quality: message.fix_quality,
      satellites: message.satellites,
      horizontal_dilution: message.horizontal_dilution.to_f,
      time: message.fix_time
      # ground_speed_kmh: message.speed_over_ground_knots * 1.852
    }
  end
end
