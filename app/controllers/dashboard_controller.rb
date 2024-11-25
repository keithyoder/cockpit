class DashboardController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { render json: data_hash }
    end
  end

private
  def data_hash
    {
      velocity: Random.rand(40..120),
      outdoor_temperature: Random.rand(10..30),
      fuel_remaining: Random.rand(0..40),
      battery_voltage: Random.rand(115..130) / 10.0,
      rpm: Random.rand(0..100) * 100
    }
  end
end
