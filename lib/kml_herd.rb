class KMLHerd
  def add_placemark(name, lat, lng, desc=nil)
    @kml ||= KMLFile.new
    pm = KML::Placemark.new(
      :name => name,
      :description => desc,
      :geometry => KML::Point.new(:coordinates =>
        {:lat => lat, :lng => lng })
    )
    @kml.objects << pm
  end

  def kml
    @kml.render
  end
end