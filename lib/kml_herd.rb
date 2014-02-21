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

  private
  def lat_lon_dist(lat1, lon1, lat2, lon2)

    deltaLat = (lat2-lat1)/180 * Math::PI
    deltaLon = (lon2-lon1)/180 * Math::PI

    a = Math.sin(deltaLat/2) * Math.sin(deltaLat/2) +
        Math.cos((lat1/180 * Math::PI)) * Math.cos((lat2/180 * Math::PI)) *
        Math.sin(deltaLon/2) * Math.sin(deltaLon/2);

    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))

    6371 * c
  end
end