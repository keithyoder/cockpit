class CreateGPSPoints < ActiveRecord::Migration[7.2]
  def change
    create_table :gps_points do |t|
      t.decimal :latitude
      t.decimal :longitude
      t.decimal :altitude
      t.integer :fix_quality
      t.integer :satellites
      t.decimal :accuracy

      t.timestamps
    end
  end
end
