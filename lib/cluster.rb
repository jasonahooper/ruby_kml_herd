class Cluster < Placemark
  require 'placemark'

  def initialize(name, lat, lng, desc=nil, pm)
    super(name, lat, lng, desc)
    @placemarks = [ pm ]
  end

  def add_placemark(pm)
    @placemarks << pm
  end

  def lat=(lat)
    self.geometry.coordinates[0] = lat
  end

  def lng=(lng)
    self.geometry.coordinates[1] = lng
  end

  def placemarks
    @placemarks
  end

end