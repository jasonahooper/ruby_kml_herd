class KMLHerd

  def add_placemark(name, lat, lng, desc=nil)
    @pms ||= []
    pm = KML::Placemark.new(
      :name => name,
      :description => desc,
      :geometry => KML::Point.new(:coordinates =>
        {:lat => lat, :lng => lng })
    )
    @pms << pm
    pm
  end

  def kml
    kml_file ||= KMLFile.new
    folder ||= KML::Folder.new(:name => 'Folder')
    @pms.each do |pm|
      folder.features << pm
    end
    kml_file.objects << folder
    kml_file.render
  end

  def placemarks
    @pms
  end

  def cluster(zoom_level)
    cluster = self.clone
    cluster.placemarks.each do |pm_from|
      cluster.placemarks.each do |pm_to|
        if pm_from != pm_to
        end
      end
    end
    cluster
  end

  def self.lat_lon_dist(lat1, lon1, lat2, lon2)
    # using 'haversine' formula with earth radius of 6371 km
    # see http://www.movable-type.co.uk/scripts/latlong.html for examples
    delta_lat = (lat2-lat1)/180.0 * Math::PI
    delta_lon = (lon2-lon1)/180.0 * Math::PI

    a = Math.sin(delta_lat/2) * Math.sin(delta_lat/2) +
        Math.cos((lat1/180.0 * Math::PI)) *
        Math.cos((lat2/180.0 * Math::PI)) *
        Math.sin(delta_lon/2) * Math.sin(delta_lon/2);

    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))

    6371 * c
  end
end