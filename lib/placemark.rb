class Placemark < KML::Placemark

  def initialize(name, lat, lng, desc=nil)
    super(:name => name,
          :geometry => KML::Point.new(:coordinates =>
            {:lat => lat, :lng => lng }
          ),
          :description => desc)
  end

  def lat
    return self.geometry.coordinates[0]
  end

  def lng
    return self.geometry.coordinates[1]
  end
end
