class Cluster < Placemark
  require 'placemark'

  def initialize(name, lat, lng, desc=nil, pm)
    super(name, lat, lng, desc)
    @placemarks = [ pm ]
  end

  def add_placemark(pm)
    @placemarks << pm
  end
end