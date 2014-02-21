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
end